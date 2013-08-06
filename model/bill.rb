
class Bill
  include Mongoid::Document
  include CarrierWave::Mount

  field :issued_by, type: String
  field :due_date, type: Date
  field :total_amount, type: Float
  field :barcode, type: String
  field :status, type: Symbol, default: :opened
  field :url, type: String
  field :filename, type: String
  mount_uploader :image, FileUploader
  field :contributor_name, type: String
  field :contributor_email, type: String
  field :receipt_url, type: String
  field :receipt_filename, type: String
  mount_uploader :receipt, ReceiptUploader

  validates_presence_of :issued_by, :due_date, :total_amount, :barcode
  validates :status, inclusion: { in: [:paid, :opened, :reserved] }
  validates_uniqueness_of :barcode

  def receipt_data_valid?
    contributor_email.present?
  end
end
