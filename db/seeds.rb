# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([( name: 'Chicago' ) ( name: 'Copenhagen' )])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Post.create( user_id: 1,	title: 'Test Post 1',		status: 'PUBLISH',	comment_status: 'PUBLIC',		content: '<h1>Test Post #1</h1><p>this is just a test post</p>',	permalink: 'test-1', created_at: Time.now, updated_at: Time.now )
Post.create( user_id: 2,	title: 'Test Post 2',		status: 'DRAFT',		comment_status: 'NONE',			content: '<h1>Test Pos #2</h1><p>this is just a test post</p>',		permalink: 'test-2', created_at: Time.now, updated_at: Time.now )
Post.create( user_id: 3,	title: 'Test Post 3',		status: 'USERS',		comment_status: 'USERS',		content: '<h1>Test Post #3</h1><p>this is just a test post</p>',	permalink: 'test-3', created_at: Time.now, updated_at: Time.now)
Post.create( user_id: 1,	title: 'Test Post 4',		status: 'EDITORS',	comment_status: 'EDITORS',	content: '<h1>Test Post #4</h1><p>this is just a test post</p>',	permalink: 'test-4', created_at: Time.now, updated_at: Time.now )
Post.create( user_id: 3,	title: 'Test Post 5',		status: 'DRAFT',		comment_status: 'NONE',			content: '<h1>Test Post #5</h1><p>this is just a test post</p>',	permalink: 'test-5', created_at: Time.now, updated_at: Time.now )
Post.create( user_id: 3,	title: 'Test Post 6',		status: 'DRAFT',		comment_status: 'NONE',			content: '<h1>Test Post #6</h1><p>this is just a test post</p>',	permalink: 'test-6', created_at: Time.now, updated_at: Time.now )
Post.create( user_id: 1,	title: 'Test Post 7',		status: 'PUBLISH',	comment_status: 'PUBLIC',		content: '<h1>Test Post #7</h1><p>this is just a test post</p>',	permalink: 'test-7', created_at: Time.now, updated_at: Time.now )
Post.create( user_id: 5,	title: 'Test Post 8',		status: 'PUBLISH',	comment_status: 'NONE',			content: '<h1>Test Post #8</h1><p>this is just a test post</p>',	permalink: 'test-8', created_at: Time.now, updated_at: Time.now )
Post.create( user_id: 6,	title: 'Test Post 9',		status: 'PUBLISH',	comment_status: 'PUBLIC',		content: '<h1>Test Post #9</h1><p>this is just a test post</p>',	permalink: 'test-9', created_at: Time.now, updated_at: Time.now )
Post.create( user_id: 7,	title: 'Test Post 10',	status: 'PUBLISH',	comment_status: 'PUBLIC',		content: '<h1>Test Post #10</h1><p>this is just a test post</p>',	permalink: 'test-10', created_at: Time.now, updated_at: Time.now )



User.create( username: 'meysam',	password: '1234', full_name: 'FN:Meysam Salehi',	bio: 'developer', 	access_level: 'ROOT', created_at: Time.now, updated_at: Time.now)
User.create( username: 'jafar',		password: 'asdf', full_name: 'FN:Dadf dsaf',			bio: 'BIO:sdfasdfs', access_level: 'ADMIN', created_at: Time.now, updated_at: Time.now)
User.create( username: 'ali',			password: 'cxvz', full_name: 'FN:asdf SADF',			bio: 'BIO:dsafsadf', access_level: 'ADMIN', created_at: Time.now, updated_at: Time.now)
User.create( username: 'reza',		password: 'ewrt', full_name: 'FN:ADFasdfsd',			bio: 'BIO:adsfdsaf', access_level: 'EDITOR', created_at: Time.now, updated_at: Time.now)
User.create( username: 'hasan',		password: 'zvcx', full_name: 'FN:sASDFfsdf',			bio: 'BIO:dfsgdffd', access_level: 'EDITOR', created_at: Time.now, updated_at: Time.now)
User.create( username: 'dsaads',	password: 'wert', full_name: 'FN:ASDFasdfs',			bio: 'BIO:fsdfgdfg', access_level: 'EDITOR', created_at: Time.now, updated_at: Time.now )
User.create( username: 'meyssa',	password: 'bvfg', full_name: 'FN:SDFsadfsd',			bio: 'BIO:fdsagdff', access_level: 'EDITOR', created_at: Time.now, updated_at: Time.now)





Comment.create( post_id: 1,	user_id: nil,	author: 'Ali-1',	author_email: 'ali@test.com',	author_url: 'example.com',	content: 'Goood!', approved: 'PUBLIC', parent_id: nil, created_at: Time.now, updated_at: Time.now )
Comment.create( post_id: 1,	user_id: nil,	author: 'Ali-2',	author_email: 'ali@test.com',	author_url: 'example.com',	content: 'Goood!', approved: 'PUBLIC', parent_id: 1, created_at: Time.now, updated_at: Time.now )
Comment.create( post_id: 1,	user_id: nil,	author: 'Ali-3',	author_email: 'ali@test.com',	author_url: 'example.com',	content: 'Goood!', approved: 'PUBLIC', parent_id: 2, created_at: Time.now, updated_at: Time.now )
Comment.create( post_id: 1,	user_id: nil,	author: 'Ali-4',	author_email: 'ali@test.com',	author_url: 'example.com',	content: 'Goood!', approved: 'PUBLIC', parent_id: 3, created_at: Time.now, updated_at: Time.now )
Comment.create( post_id: 1,	user_id: nil,	author: 'Ali-5',	author_email: 'ali@test.com',	author_url: 'example.com',	content: 'Goood!', approved: 'PUBLIC', parent_id: nil, created_at: Time.now, updated_at: Time.now )
Comment.create( post_id: 1,	user_id: nil,	author: 'Ali-6',	author_email: 'ali@test.com',	author_url: 'example.com',	content: 'Goood!', approved: 'PUBLIC', parent_id: 5, created_at: Time.now, updated_at: Time.now )
Comment.create( post_id: 1,	user_id: nil,	author: 'Ali-7',	author_email: 'ali@test.com',	author_url: 'example.com',	content: 'Goood!', approved: 'PUBLIC', parent_id: nil, created_at: Time.now, updated_at: Time.now )
Comment.create( post_id: 1,	user_id: 2,		author: nil,			author_email: nil,						author_url: nil,						content: 'Goood!', approved: 'PUBLIC', parent_id: 7 , created_at: Time.now, updated_at: Time.now)
Comment.create( post_id: 1,	user_id: nil,	author: 'Ali-9',	author_email: 'ali@test.com',	author_url: 'example.com',	content: 'Goood!', approved: 'PUBLIC', parent_id: 8 , created_at: Time.now, updated_at: Time.now)
Comment.create( post_id: 1,	user_id: 1,		author: nil,			author_email: nil,						author_url: nil,						content: 'Goood!', approved: 'PUBLIC', parent_id: nil , created_at: Time.now, updated_at: Time.now)
Comment.create( post_id: 1,	user_id: 3,		author: nil,			author_email: nil,						author_url: nil,						content: 'Goood!', approved: 'PUBLIC', parent_id: nil , created_at: Time.now, updated_at: Time.now)
Comment.create( post_id: 1,	user_id: 1,		author: nil,			author_email: nil,						author_url: nil,						content: 'Goood!', approved: 'PUBLIC', parent_id: nil, created_at: Time.now, updated_at: Time.now )
