# frozen_string_literal: true

class << ActiveRecord::Base
  if not method_defined?(:find_by)
    def find_by(*args)
      where('').find_by(*args)
    end
  end
end

class ActiveRecord::Relation
  if not method_defined?(:find_by)
    def find_by(*args)
      where(*args).order('').first
    end
  end
end
