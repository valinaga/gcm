# gcm

gcm sends push notifications to Android devices via google [gcm](http://developer.android.com/guide/google/gcm/gcm.html).

##Installation

    $ gem install gcm
    
##Requirements

An Android device running 2.2 or newer, its registration token, and a google account registered for GCM.

##Usage

There are two ways to use GCM.

Sending many notifications:

    notifications = [
      {
        :registration_id => "...", 
        :data => {
          :message => "Some message",
          :score => 10
        },
        :collapse_key => "foobar" #optional
      },
      ....
    ]
  
    GCM.auth_key = 'my-authentication-key-from-gcm'
    GCM.send_notifications(notifications)
  
  or with authentication key...

    GCM.send_notifications(notifications, 'my-authentication-key-from-gcm')

...or one at a time:

    gcm = GCM.new('my-authentication-key-from-gcm')
  
    notification = {
      :registration_id => "...", 
      :data => {
        :some_message => "Some message",
        :another_message => 10
      },
      :collapse_key => "foobar" #optional
    }
  
    gcm.send_notification(notification)

If you want to send multicast notification, use instead the plural of the registration_id and an array.

    registration_ids  => ['reg_idq', 'reg_id2',....]

You can get the statistics of what you sent by inspecting the:
    :successes, :failurese, :canonicals 
at the class level if many notifications are sent, ex:
        
    GCM.successes  or GCM.failures
    
or at instance level if you are sending only one or multicast, ex:
        
    gcm = GCM.new('my-authentication-key-from gcm')
    ......
    gcm.send_notification(notification)
    puts gcm.successes, gcm.failures, gcm.canonicals
     
Good luck!

##Copyrights

* Copyright (c) 2010-2012 Valentin Nagacevschi. See LICENSE.txt for details.

##Thanks
* [Amro Mousa] (https://github.com/amro/c2dm)
* [Paul Chun](https://github.com/sixofhearts)
* [gowalla](https://github.com/gowalla)
