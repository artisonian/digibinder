require 'basic_model/basic_model'

class Section < BasicModel
  
  def default_attributes
    return {
      "tags" => []
    }
  end
  
  def on_update
    if (tags = @attributes['tags']) && tags.is_a?(String)
      @attributes['tags'] = tags.split(' ')
    end
  end
  
end