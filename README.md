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
  
    GCM.auth_key = '1234567890qwertyuiiop'
    GCM.send_notifications(notifications)
  
  or with authentication key...

    GCM.send_notifications(notifications, '1234567890qwertyuiiop')

...or one at a time:

    GCM = GCM.new('1234567890qwertyuiiop')
  
    notification = {
      :registration_id => "...", 
      :data => {
        :some_message => "Some message",
        :another_message => 10
      },
      :collapse_key => "foobar" #optional
    }
  
    GCM.send_notification(notification)

If you wnat to send multicast notification, use the plural of the registration_id and an array.
That is, registration_ids  => ['reg_idq', 'reg_id2',....].
Good luck!

##Copyrights

* Copyright (c) 2010-2012 Valentin Nagacevschi. See LICENSE.txt for details.

##Thanks
* [Amro Mousa] (https://github.com/amro/c2dm)
* [Paul Chun](https://github.com/sixofhearts)
* [gowalla](https://github.com/gowalla)
