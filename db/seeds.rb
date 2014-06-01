# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin User
dobestan = User.create( name: "dobestan",
                        password: "dkstncks",
                        password_confirmation: "dkstncks",
                        admin: true)

# Demo User
demo = User.create( name: "demo",
                    password: "foobar",
                    password_confirmation: "foobar" )


# Homepage ( Link #1 )
homepage = Link.create( original: "http://ansuchan.com",
                        shorten: "homepage",
                        message: "Personal Homepage by @dobestan" )

# Tech Blog ( Link #2 )
blog = Link.create( original: "http://blog.ansuchan.com",
                    shorten: "blog",
                    message: "Personal Tech Blog by @dobestan")

# Github ( Link #3 )
github = Link.create( original: "http://github.com/dobestan",
                       shorten: "github",
                       message: "Github by @dobestan")

# Facebook ( Link #4 )
facebook = Link.create( original: "http://facebook.com/dobestan",
                        shorten: "facebook",
                        message: "Facebook")
