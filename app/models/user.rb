# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  email                 :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  political_affiliation :string           not null
#  age                   :integer          not null
#
class User < ApplicationRecord
    validates :username, :email, presence: true, uniqueness: true
    # validates(:username, :email, {presence: true, uniqueness: true})
    validates :political_affiliation, :age, presence: true

    has_many :chirps,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :Chirp

    has_many :likes,
        primary_key: :id,
        foreign_key: :liker_id,
        class_name: :Like

    has_many :liked_chirps,
        through: :likes,
        source: :chirp

    # User.first #grabs the first isntance of user in our database by id
    # User.last #grab the last user by id

    # #find will error out if it doesnt finds what you need 
    # #find_by will not error out but actually return nil if it doesnt find what you need

    # User.find(???) # takes in an id, and is going to return a user by that id
    # #key is the column in the table 
    # #value is what you are looking for
    # User.find_by(key: :value) #search the database for a model that has a key value pair that we passed in 

    # # ! where 

    # User.where(age: 10..20)
    # User.where.not("age <= 11")
    # User.where.not("age <= ?", "11")

    # instructors = ["give_me_wine", "lina_2020", "wakka_wakka"]
    # User.where(username: instructors).order(:username) 
    # User.where(username: instructors).order(username: :desc)

    # User.where("username in (?) ", instructors).order(:username)

    # # ! joins

    # #find all the chirps for the user with the username "charlos_gets_buckets" ???
    # # * jeopardy music*
    # #steps:
    # #1. find the instance we're looking for 
    # # this works 
    # User.find_by(username: "charlos_gets_buckets").chirps
    # #lets do it with one query though...
    # User.select("chirps.*").joins(:chirps).where(username: "charlos_gets_buckets")
end
