class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role == "admin"
      can :manage, :all
    end
    if user.role == "user"
      can [:index,:show], [Post,Category]
      can [:create], Post
      # can :index, User
      # can :edit, User
      can :update, User do |u|
        u == user
      end
      can [:update, :destroy], Post do |post|
        post.user == user
      end
    end

    if user.role == nil
      can :index, Post
      can :show, Post
      can :show, Category
      # can :index, User
      # can :edit, User
      # cannot :create, Post
    end


    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
