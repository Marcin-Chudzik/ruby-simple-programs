# frozen_string_literal: true

Animal = Object.new

def Animal.taxonomic_name
  'animalia'
end

def Animal.new
  @taxonomic_hierarchy ||= []
  @taxonomic_hierarchy << taxonomic_name
  clone
end

def Animal.taxonomic_hierarchy
  @taxonomic_hierarchy
end

Dinosaur = Animal.new
def Dinosaur.taxonomic_name
  'dinosauria'
end

Tyrannosaurus = Dinosaur.new
def Tyrannosaurus.taxonomic_name
  'tyrannosaurus rex'
end

Tyrant = Tyrannosaurus.new
puts Tyrant.taxonomic_hierarchy





module Persistable
  def save
    puts 'save'
  end

  module ClassMethods
    def find(_id)
      puts 'find'
      new
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end

class Post
  include Persistable

  attr_accessor :title
end

post = Post.find(123)
post.title = 'test'
post.save

module Validatable
  def save
    puts 'validating'
  end
end

class Test
  prepend Validatable
  def save
    puts 'saving'
  end
end

p = Test.new
p.save

puts Test.ancestors
