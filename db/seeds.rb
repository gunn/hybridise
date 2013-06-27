require "excon"

class WikiImport
  def self.connection
    @connection ||= Excon.new "http://en.wikipedia.org/w/api.php"
  end

  def self.load_page slug
    response = connection.get query:
      { action:'parse', prop:'text', format:'json', page: slug }

    data = JSON.parse( response[:body] )
    html_text = data["parse"]["text"]["*"]

    Nokogiri::HTML(html_text)
  end

  def find_subjects
    doc = WikiImport.load_page "List_of_academic_disciplines"

    links = doc.css(".multicol td > ul > li > a")
    links = links.reject do |a|
      ["Outline", "outline", " of ", " sociology"].any? do |word|
        a.text.include? word
      end
    end

    subjects = links.map do |a|
      Subject.new title: a.text, wiki_slug: a["href"].sub(/\A\/wiki\//, "")
    end
  end

  def get_subject_text slug
    doc = WikiImport.load_page slug

    p = doc.css("p:first")
    p.css("sup").remove
    p.css("a").each { |a| a["href"] = "http://en.wikipedia.org#{a["href"]}" }

    text = p.to_s
  end

  def import!
    subjects = find_subjects
    total = subjects.size
    Rails.logger.info "Importing #{total} subjects:\n"

    subjects.each_with_index do |subject, i|
      Rails.logger.info "(#{i} / #{total}) #{subject.title}"
      begin
        subject.text = get_subject_text( subject.wiki_slug )
      rescue
        Rails.logger.info("Error with #{subject.title}")
      end

      subject.save
    end
  end
end

WikiImport.new.import!
