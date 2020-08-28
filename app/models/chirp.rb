# == Schema Information
#
# Table name: chirps
#
#  id        :bigint           not null, primary key
#  body      :text             not null
#  author_id :integer          not null
#
class Chirp < ApplicationRecord
    validates :body, presence: true
    # validates :body, :author_id, presence: true
    validate :body_too_long

    # always start with tables that have foreign keys(author_id)

    # **Where the foreign key lives is where you write your belongs to**

    belongs_to :author,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User

    # Every time you write a belongs to, write the corresponding has_many/has_one

    has_many :likes,
        primary_key: :id,
        foreign_key: :chirp_id,
        class_name: :Like

    has_many :likers,
        through: :likes,
        source: :liker

    def body_too_long
        if body && body.length > 140
            errors[:body] << "Too Long!!"
        end
    end

    # #get us all the chirps for the username charlos_gets_buckets
    # #this be wrong because it tries to find username on our chirps table
    # Chirp.joins(:author).where(username: "charlos_gets_buckets")
    # #this be the correct answer
    # Chirp.joins(:author).where(users: {username: "charlos_gets_buckets"})

    # #find all the chirps liked by people politically affiliated with JavaScript ???
    # Chirp.joins(:likers).where("users.political_affiliation = (?) ", "JavaScript").group(:id)

    # #how can we find all chirps with no likes???
    # Chirp.left_outer_joins(:likes).where(likes: {liker_id: nil})
    # Chirp.joins(:likes).where(likes: {liker_id: nil})

    # #find how many likes that each chirps has
    # Chirp.select(:id,:body,"COUNT (*) as num_likes").joins(:likes).group(:id)

    # #find all the chirps with atleast three likes lets and lets use pluck to pluck the body
    # Chirp.joins(:likes).group(:id).having("COUNT(*) >= 3").pluck(:body)
    # Chirp.joins(:likes).group(:id).having("num_likes >= 3").select(:body,:id,"COUNT(*) as num_likes")

    # #find all the chirps created by someone that is 11 BUT also like by someone that is 11
    # Chirp.joins(:likers,:author).where(users: {age: 11}).where(authors_chirps: {age: 11})

    # N + 1 query 
    def self.see_chirp_authors_n_plus_1 
        #this is + 1
        chirps = Chirp.all

        chirps.each do |chirp| # this is our N
            p chirp.author.username
        end
    end

    def self.see_chirp_authors_optimized 
        
        # chirps = Chirp.includes(:author).all
        chirps = Chirp.all.includes(:author) # all is lazy and includes is also lazy

        chirps.each do |chirp| 
            p chirp.author.username
        end
    end

    def self.see_chirps_likes_n_plus_1
        chirps = Chirp.all

        chirps.each do |chirp|
            p chirp.likes.length
        end
    end

    def self.see_chirps_likes_optimized
        chirps = Chirp.select("chirps.*, COUNT(*) as num_likes").joins(:likes).group(:id)

        chirps.each do |chirp|
            p chirp.num_likes
        end
    end
end
