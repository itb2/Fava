class PostsController < ApplicationController
	layout 'internal'
  def index
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @posts = Post.all
    else
      redirect_to root_path
    end
  end

  def new
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
  	   @post = Post.new
  	   @restaurants = Restaurant.all
    else
        redirect_to root_path
    end
  end
  
  def index
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @posts = Post.all
      else
        redirect_to root_path
      end
  end

  def list_restaurants
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @restaurants = Restaurant.all
      else
        redirect_to root_path
      end
  end

  def list_food
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @restaurant = Restaurant.find_by_id(params[:restaurant])
          @food_items = FoodItem.where(:Restaurant_id => params[:restaurant])

      else
        redirect_to root_path
      end
  end

  def food_item_profile
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @food_item = FoodItem.find_by_id(params[:food_item])
          @restaurant = Restaurant.find_by_id(@food_item.Restaurant_id)
          @size_not_empty = (@food_item.size != "\\N")
          @allergy_not_empty = (@food_item.allergy_info != "\\N")

      else
        redirect_to root_path
      end
  end

  def filter
    
  end

  def filter_by_cat
       @food_items = FoodItem.where(:category => params[:category])
          @category = params[:category]
  end

  def order
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
        if params[:food_item] != nil
          @food_item = FoodItem.find_by_id(params[:food_item])
          @restaurant = Restaurant.find_by_id(@food_item.Restaurant_id)
          @post = Post.new
        elsif post_params[:food_name] != nil
          raise "error"
        else
          raise "error"
        end
      else
        redirect_to root_path
      end
  end


  # create post
  def create
      if post_params[:food_name] != nil
        fava_user = FavaUser.find_by_id(session[:fava_user_id])
        @restaurant = Restaurant.find_by_id(post_params[:restaurant_id])
        @food_item = FoodItem.find_by_id(post_params[:food_item_id])
        #fix this!!
        @post = Post.new(:poster => fava_user.id, :claimer => nil, :food_item_id => @food_item.id, :tip => post_params[:tip], :notes => post_params[:notes], :status => 0)
      else
        raise "error"
      end
      respond_to do |format|
        flash.now[:info] = "Your request has been posted"
        flash.keep
        format.html {redirect_to timeline_path}
      end

   #  restaurant_id = Restaurant.where(:name => params[:restaurant_name])
   #  food_id = FoodItem.where(:food_name => params[:food_name], :Restaurant_id => restaurant_id)
   #  @post = Post.new(FoodItem_id: food_id, )
	  # respond_to do |format|
	  #   flash.now[:info] = "Your request has been posted"
	  #   format.html {redirect_to timeline_path}
	  #  end
  end


  def post_params
      params.require(:post).permit(:food_item_id, :restaurant_id, :food_name, :restaurant_name, :notes, :tip)

  end


end
