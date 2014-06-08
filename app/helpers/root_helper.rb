module RootHelper

  def info_hash
    { 
      'Current Time'  => 'now'.chronitize( :datetime, true ),
      'Browser'       => current_browser,
      'Current User'  => ( current_user || "none (pit #{ User.pit.id ? 'exists, see app/models/user.rb for credentials' : 'is missing' })" )
    }
  end

end
