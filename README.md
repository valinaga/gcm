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
        :message => "Some payload"
        :score => 10
      },
      :collapse_key => "foobar" #optional
    }
  ]
  
  GCM.auth_key = '1234567890qwertyuiiop'
  GCM.send_notifications(notifications)
  
  or with authentication key...

  GCM.send_notifications(notifications, '1234567890qwertyuiiop')

...or one at a time:

  GCM = GCM.new('1234567890qwertyuiiop')

  notification = {
    :registration_ids => ["..."], 
    :data => {
      :some_message => "Some payload",
      :another_message => 10
    },
    :collapse_key => "foobar" #optional
  }

  GCM.send_notification(notification)

Note the registration_ids as plural! And it takes an array even if it's only one registration_id.
You can use the same for multicast.  => ['reg_idq', 'reg_id2',....]

##Copyrights

* Copyright (c) 2010-2012 Valentin Nagacevschi. See LICENSE.txt for details.

##Thanks
* [Amro Mousa] (https://github.com/amro/c2dm)
* [Paul Chun](https://github.com/sixofhearts)
* [gowalla](https://github.com/gowalla)
