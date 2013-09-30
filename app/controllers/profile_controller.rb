class ProfileController < UIViewController
  attr_accessor :user, :media

  def initWithUser(user)
    initWithNibName(nil, bundle: nil)
    self.user = user
    self.user.get_media do |recent_media|
      self.media = recent_media
      @table.reloadData
    end

    self
  end

  def viewDidLoad
    super
    self.title = "Instagram Picture of User"

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    self.view.addSubview @table

    @table.dataSource = self
    @table.delegate = self
  end

  ##Table Data source
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    #return the UITableViewCell for the row
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      PictureCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)  
    end

    #this is very slow because it is trying to load from the internet while loading.. what is a better way? Loading into memory will just crash the app I believe
    url = NSURL.URLWithString @media[indexPath.row].image_link
    # NSURL *url = [NSURL URLWithString:path];

    data = NSData.dataWithContentsOfURL url
    # NSData *data = [NSData dataWithContentsOfURL:url];

    # UIImage *img = [[UIImage alloc] initWithData:data cache:NO];
    #put your data in the cell
    cell.image = UIImage.alloc.initWithData(data)

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    #return the number of rows available
    self.media.nil? ? 0 : self.media.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    PictureCell.cell_height
  end

end