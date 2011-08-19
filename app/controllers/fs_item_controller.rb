class FsItemController < ApplicationController

  def index
    @fs_items = FsItem.all
    @fs_item = FsItem.new
    respond_to do |format|
      format.json { render :json => @fs_items }
    end
  end

  def show
    @fs_item = FsItem.find(params[:id])
    respond_to do |format|
      format.json { render :json => @fs_item }
    end
  end

  def children
    path = params[:path]
    if path.nil? or path.blank?
      @dir = nil
    else
      @dir = FsItem.find_by_path!(params[:path])
    end
    logger.debug "The object is #{@dir}"
    @fs_items = FsItem.where(:parent_id => @dir.nil? ? nil : @dir.id).all
    respond_to do |format|
      format.json { render :json => @fs_items }
    end
  end

end

