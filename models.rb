class Section
  attr_accessor :attributes, :db
  
  def initialize(database, extra_attributes={})
    @db = database
    @attributes = {:type => 'section'}
    @attributes.merge!(extra_attributes)
  end
  
  def save
    on_update
    
    response = @db.save(@attributes)
    doc = @db.get(response['id'])
  end
  
  def on_update
    @attributes['tags'] = @attributes['tags'].split(' ')
  end
  
end