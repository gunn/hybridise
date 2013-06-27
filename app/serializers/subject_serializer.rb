class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :wiki_slug
  attributes :text

  def include_text?
    options[:include_text]
  end
end
