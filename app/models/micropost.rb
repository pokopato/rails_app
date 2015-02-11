class Micropost < ActiveRecord::Base
  belongs_to :user
  
  
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  # ファイル用の属性を追加するhas_attached_fileメソッド
  has_attached_file :image, styles: { medium: "200x150>", thumb: "50x50>" }
  
  #  画像の拡張子を限定するためのvalidatorを定義
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],
                                    :message => "JPG, GIF, PNGのみアップロードできます"
  
  # ファイルサイズ制限
  validates_attachment_size :image, :less_than => 100.kilobytes, 
                            :message => "ファイルサイズが大きすぎます(最大 100kByte まで)"
  
  # 与えられたユーザーがフォローしているユーザー達のマイクロポストを返す。
  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user)
  end
end
