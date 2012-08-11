# gcm

gcm sends push notifications to Android devices via google [gcm](http://developer.android.com/guide/google/gcm/gcm.html).

##Installation

    $ gem install gcm
    
##Requirements

An Android device running 2.2 or newer, its registration token, and a google account registered for GCM.

##Usage

*Important*: Version 0.2.0+ decouples auth from sending so the API changed. Please update your code.

There are two ways to use GCM.

Sending many notifications:

  notifications = [
    {
      :registration_id => "...", 
      :data => {
        :some_message => "Some payload"
        :another_message => 10
      },
      :collapse_key => "foobar" #optional
    }
  ]
  
  GCM.authenticate!("your@googleuser.com", "somepassword", "YourCo-App-1.0.0")
  GCM.send_notifications(notifications)

...or one at a time:

  GCM.authenticate!("your@googleuser.com", "somepassword", "YourCo-App-1.0.0")
  GCM = GCM.new

  notification = {
    :registration_id => "...", 
    :data => {
      :some_message => "Some payload",
      :another_message => 10
    },
    :collapse_key => "foobar" #optional
  }

  GCM.send_notification(notification)

Note that calling *authenticate!* will authenticate all new instances of GCM. You can override this by passing in your own auth_token:

  GCM = GCM.new(auth_token)

##Copyrights

* Copyright (c) 2010-2012 Valentin Nagacevschi. See LICENSE.txt for details.

##Thanks
* [Amro Mousa] (https://github.com/amro/c2dm)
* [Paul Chun](https://github.com/sixofhearts)
* [gowalla](https://github.com/gowalla)
