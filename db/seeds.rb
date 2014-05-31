# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dobestan = User.create( name: "dobestan",
                        password: "dkstncks",
                        password_confirmation: "dkstncks",
                        admin: true)

demo = User.create( name: "demo",
                    password: "foobar",
                    password_confirmation: "foobar" )


blog = Link.create( original: "http://blog.ansuchan.com",
                    shorten: "blog",
                    message: "Personal Tech Blog by @dobestan")

homepage = Link.create( original: "http://ansuchan.com",
                        shorten: "homepage",
                        message: "Personal Homepage by @dobestan" )

private_link_example = Link.create( original: "http://naver.com",
                                    shorten: "naver",
                                    message: "Naver | 네이버",
                                    public: false )
