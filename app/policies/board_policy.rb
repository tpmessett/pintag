class BoardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def index?
    return true
  end

  def create?
    return true
  end

  def new?
    return true
  end

  def show?
    return true
  end

  def update?
    return true
  end

  def edit?
    return true
  end

  def send_to_slack?
    return true
  end

  def destroy?
    return true
  end
  def share?
    return true
  end
end
