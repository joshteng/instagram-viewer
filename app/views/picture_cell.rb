class PictureCell < UITableViewCell
  attr_accessor :image
  @@cell_height = 320

  def self.cell_height
    @@cell_height
  end
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super
    self.selectionStyle = UITableViewCellSelectionStyleNone

    self
  end


  def image=(image)
    @image = image
    self.setNeedsDisplay
  end


  def drawRect(rect)
    image_view = UIImageView.alloc.initWithImage(self.image)

    image_view.center = CGPointMake((self.frame.size.width/2), (self.frame.size.height/2));

    self.addSubview(image_view)
  end

end