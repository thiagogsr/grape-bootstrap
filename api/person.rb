module GrapeBootstrap
  class PersonAPI < Grape::API
    resource :people do
      desc "Return a all people."
      get do
        Person.all.to_a
      end

      desc "Create a person."
      params { requires :name, type: String }
      post do
        Person.create(name: params[:name])
      end
    end

    resource :person do
      desc "Return a person."
      params { requires :id, type: String }
      get ':id' do
        Person.find(params[:id])
      end

      desc "Update a person."
      params do
        requires :id, type: String
        requires :name, type: String
      end
      put ':id' do
        person = Person.find(params[:id])
        person.update(name: params[:name])
      end

      desc "Delete a person."
      params { requires :id, type: String }
      delete ':id' do
        person = Person.find(params[:id])
        person.destroy
      end
    end
  end
end