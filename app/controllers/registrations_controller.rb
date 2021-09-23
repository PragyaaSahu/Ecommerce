class RegistrationsController < Devise::RegistrationsController
  after_action :set_role, only: [:create]
  # def new
  #   super
  # end

  def create
    super
    # add custom create logic here
  end

  # def update
  #   super
  # end

  private

  def set_role

	 if params[:role]=="true"
	   resource.add_role(:customer)
		 resource.save
	 else
		 resource.add_role(:supplier)
		 resource.save
	 end
  end

end 