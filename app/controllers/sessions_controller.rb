class SessionsController < ApplicationController
  def new
  end

  def create
  	user = Student.find_by(id_num: params[:session][:ID_number])
    admin = Admin.find_by(admin_id: params[:session][:ID_number])
  	if user && user.password == params[:session][:password]
  		session[:id] = user.id_num
      session[:name] = user.name
  		flash[:notice] = nil
  		redirect_to requests_path
    elsif admin && admin.password == params[:session][:password]
      session[:id] = admin.admin_id
      session[:name] = admin.name
      session[:admin] = true
      flash[:notice] = nil
      redirect_to requests_path
  	else
  		flash[:notice] = 'Invalid ID/password'
  	  render 'new'
  	end
  end

  def destroy
    Request.where(student_id: session[:id]).destroy_all
    session[:id] = nil
    session[:name] = nil
    session[:admin] = nil
    redirect_to '/login'
  end
end
