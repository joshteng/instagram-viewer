class SearchResultController < UIViewController
  attr_accessor :users

  def initWithUsers(users)
    initWithNibName(nil, bundle: nil)
    self.users = users
    self
  end

  def viewDidLoad
    super
    self.title = "Select Instagram User"

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
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)  
    end

    #put your data in the cell
    cell.textLabel.text = self.users[indexPath.row].username

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    #return the number of rows available
    self.users.count
  end

  #Table Delegate
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    user = self.users[indexPath.row]

    self.navigationController.pushViewController(ProfileController.alloc.initWithUser(user), animated: true)
  end


end