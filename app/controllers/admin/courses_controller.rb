require 'csv'

module Admin
  class CoursesController < BaseController
    load_and_authorize_resource :course, :through => :current_user

    def index
      respond_to do |format|
        format.html # index.html.erb
      end
    end

    def show
      respond_to do |format|
        format.html # show.html.erb
      end
    end

    def new
      respond_to do |format|
        format.html # new.html.erb
      end
    end

    def edit
    end

    def create
      respond_to do |format|
        if @course.save
          format.html { redirect_to([:admin, @course], :notice => 'Course was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    end

    def update
      respond_to do |format|
        if @course.update_attributes(params[:course])
          format.html { redirect_to([:admin, @course], :notice => 'Course was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    def destroy
      @course.destroy

      respond_to do |format|
        format.html { redirect_to [:admin, :courses] }
      end
    end

    def export
      knotebooks = @course.knotebooks.order("due_at ASC").select([:title, :id])

      csv_file = CSV.generate do |csv|
        csv << [
          "Student ID",
          "Last Name",
          "First Name",
          knotebooks.map(&:title)
        ].flatten
        @course.students.find_each do |student|
          csv << [
            student.student_id,
            student.last,
            student.first,
            knotebooks.map do |kb|
              kb.reports.for(student).first.grade || "-"
            end
          ].flatten
        end
      end

      filename = [
        @course.short_name.downcase.gsub(/\W/,''),
        @course.semester.downcase.gsub(/\W/,''),
        Time.now.strftime("%y-%m-%d")
      ].join("_")

      send_data csv_file, :filename => filename, :type => :csv
    end
  end
end