Trestle.resource(:open_hours) do
  remove_action :new, :destroy

  menu do
    item :open_hours, icon: "fa fa-calendar"
  end

  collection { OpenHour.order(id: :asc) }

  table do
    column :verbose_day_of_week
    column :parsed_open_time
    column :parsed_close_time
  end

  form do |open_hour|
    text_field :verbose_day_of_week, disabled: true
    time_field :open_time
    time_field :close_time
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:open_hour).permit(:name, ...)
  # end
end
