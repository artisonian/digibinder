require 'basic_model/lib/basic_model'

class Section < BasicModel
  
  def default_attributes
    return {
      :tags => []
    }
  end
  
  def on_update
    self.tags = self.tags.split(' ')
  end
  
end