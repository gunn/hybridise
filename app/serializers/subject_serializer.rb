class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :wiki_slug, :complete, :text

  def complete
    !!options[:complete]
  end

  def include_text?
    options[:include_text]
  end
end
