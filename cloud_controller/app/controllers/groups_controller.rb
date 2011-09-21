class GroupsController < ApplicationController
  before_filter :find_group_by_name, :except => [:create]
  
  def create
    name = body_params[:groupname]
    sequence = body_params[:appsequence]
    group = Group.find_by_name(name)
    
    if(!group)
      group = ::Group.new(:name => name, :sequence => sequence)
    else
      group.sequence = sequence
    end
    
    begin
      group.save!
    rescue => e
      raise e
    end
        
    render :json => {:result => 'success'}, :status => 302
  end
  
  def get
    render :json => @group.as_json
  end
  
  def find_group_by_name
    @group = Group.find_by_name(params[:name])
    raise CloudError.new(CloudError::GROUP_NOT_FOUND) unless @group  
  end  
end
