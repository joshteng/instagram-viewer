class SearchController < UIViewController
  def viewDidLoad
    super

    self.title = "Search Instagram Picture of User"

    self.view.backgroundColor = UIColor.whiteColor

    @text_field = UITextField.alloc.initWithFrame [[0,0], [160, 26]]
    @text_field.placeholder = "joshteng"
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    @text_field.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 100)
    self.view.addSubview @text_field

    @search = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @search.setTitle("Search", forState:UIControlStateNormal)
    @search.setTitle("Loading", forState:UIControlStateDisabled)
    @search.sizeToFit
    @search.center = CGPointMake(self.view.frame.size.width / 2, @text_field.center.y + 40)
    self.view.addSubview @search



    @search.when(UIControlEventTouchUpInside) do
      @search.enabled = false
      @text_field.enabled = false

      username = @text_field.text
      # chop off any leading @s
      username = username[1..-1] if username[0] == "@"

      InstagramUser.search(username) do |users|
        if users.empty?       
          @search.enabled = true
          @text_field.enabled = true
          @search.setTitle("Try Again", forState: UIControlStateNormal)
        else
          @search.enabled = true
          @text_field.enabled = true
          self.navigationController.pushViewController(SearchResultController.alloc.initWithUsers(users), animated: true)
        end
      end
    end
  end

end