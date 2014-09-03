---

This sample project was created as part of my talk at [iOSDevUK] in september 2014. It is heavily inspired by the very beggining of the CI pipeline of the [SoundCloud] iOS app. As such, massive thanks go to [@jberkel], [@nerdsRob], [@SlavkoKrucaj], [@michaelengland], [@ssmiech], [@rmaz] and [@dmrschmidt]. You're all awesome.

---

# What is this?

The goal is to automate the release process of your app (be it an alpha or AppStore build), forget about Product -> Archive and let the machines work for you.

The `Rakefile` provides the following tasks:

```
rake build:build    # build the app
rake build:clean    # clean the build
rake build:sim_app  # generate an installable app (simulator)
rake ci:ci          # ci pipeline
rake ci:unit_test   # run the unit test suite
rake clean          # Remove any temporary products
rake clobber        # Remove any generated file
rake deploy:hockey  # upload ipa to HockeyApp
rake ipa:ipa        # build an installable ipa
rake ipa:sign_ipa   # sign an existing app in the target folder
rake plist          # generate environment plist
rake pods           # install pods
```

Here are some jobs you could create on a build server like jenkins:

__master__ (triggered by every commit on branch `master`)

```
rake ci:ci
```

__deploy_alpha__ (triggered when __master__ is successful)

```
rake ipa:ipa deploy:hockey BUILD_ENV=alpha
```

__release__ (triggered by every commit on branch `release`)

```
rake ci:ci
```

__deploy_beta__ (triggered when __release__ is successful)

```
rake ipa:ipa deploy:hockey BUILD_ENV=beta
```

__deploy_release__ (triggered when __release__ is successful)

```
rake ipa:ipa BUILD_ENV=release \
&& rake ipa:sign_ipa BUILD_ENV=adhoc
```

And there you go, you'll get new alpha versions of your app automatically every time you commit to `master` and new beta versions every time you commit on the `release` branch. If you're satisfied with the beta, the AdHoc and AppStore IPAs are already waiting for final QA. Distribute the AdHoc build internally, test it, then fire up [Application Loader] and submit the AppStore ipa.

That's not all, the `plist` task generates an `Environment.plist` file that's included in the application bundle. In this sample code, an api base URL changes depending on the version being build. This could also be used for a number of other things including: facebook app IDs, Google+ app IDs, logger settings, crash reporter app IDs...

If you set the environment variable `CI_BUILD_NUMBER` on your build server, it'll be used as the build number in your app. Making it very easy to distinguish between all the different builds of your next release.

# How do I use this?

I'd like this to be super easy to setup, but it isn't. Every app is different and needs different steps to build, there's no one size fits all. You should probably have a look at the ruby files and take what you need to get started.

First, check out the `.build.yml` file. This is where everything is setup. You should change this to fit your app. Mainly the `display_name`, `bundle_identifier`, `signing_identity` and `provisioning_profile` values are useful when you get started.

Then, have a look at the `Evironment` class, I think what that brings you is a lot of flexibility to deploy different versions of your app.

```
rake ci:ci
```

Don't try to do everything at once, start small and iterate!

# It doesn't work on my CI server

Don't pull you hair out just yet.

 * The rake command does not work

```
GEM_HOME=./vendor gem install bundler --bindir ./bin \
&& GEM_HOME=./vendor ./bin/bundle install --binstubs --path vendor/bundle \
&& GEM_HOME=./vendor ./bin/bundle clean --force \
&& GEM_HOME=./vendor ./bin/bundle exec rake ci:ci
```

 * When building, a prompt asks to unlock the keychain

If you set the `KEYCHAIN_PASSWORD` environment variable on your build machine, the keychain will be unlocked when building your app.

If you don't like this method, you could also store the password somewhere on your build machine and modify the code used to retreive it, it's in `build.rb`

 * The codesign step fails

I'm very sorry. Check that the necessary developer certificates and provisioning profiles are installed and valid (use Keychain Access and [iPhone configuration Utility])

You can also open an issue or send me a tweet ([@garriguv])

[iOSDevUK]: http://www.iosdevuk.com/
[SoundCloud]: http://www.soundcloud.com/
[@jberkel]: http://github.com/jberkel
[@nerdsRob]: http://github.com/nerdsRob
[@SlavkoKrucaj]: http://github.com/SlavkoKrucaj
[@michaelengland]: http://github.com/michaelengland
[@ssmiech]: http://github.com/ssmiech
[@rmaz]: http://github.com/rmaz
[@dmrschmidt]: http://github.com/dmrschmidt
[Application Loader]: https://itunesconnect.apple.com/docs/UsingApplicationLoader.pdf
[iPhone configuration Utility]: http://support.apple.com/downloads/#iphone%20configuration%20utility
[@garriguv]: http://twitter.com/garriguv

# Useful things

Have a look at `imobiledevice`, `ideviceinstaller` and `ios-sim`, these utilities are super useful when you work a lot with the command line.

You can install all of them with `brew`.

# License

Copyright (c) 2014 Vincent Garrigues. See the LICENSE file for license rights and limitations (MIT).
