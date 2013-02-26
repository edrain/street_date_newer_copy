class WheneverTest
  
    @today = Date.today-12
    ReleaseNotifier.admin_notify(@today).deliver      
  
  
end