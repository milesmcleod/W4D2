class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validate :overlapping_approved_requests

  STATUS = ["PENDING","APPROVED","DENIED"]

  validates :status,  inclusion: { in: STATUS, message: 'invalid status'}

  belongs_to :cat


  def overlapping_requests
    CatRentalRequest
      .where("cat_id = #{self.cat_id}")
      .where("(start_date BETWEEN '#{self.start_date}' AND '#{self.end_date}') OR
              ('#{self.start_date}' BETWEEN start_date AND end_date)")
  end

  # (start_date BETWEEN '#{self.start_date}' AND '#{self.end_date}') OR
  #         (end_date BETWEEN '#{self.start_date}' AND '#{self.end_date}')

  def overlapping_approved_requests
    if self.overlapping_requests.where("status = 'APPROVED'").exists?
      errors.add(:status, "overlapping request")
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING' ")
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def deny!
    CatRentalRequest.transaction do
      self.update(status: "DENIED")
    end
  end

  def pending?
    self.status == "PENDING"
  end

end
