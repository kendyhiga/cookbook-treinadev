admin = User.create(name: 'Admin', email: 'admin@email.com', password: '123456', admin: true)
user = User.create(name: 'John Doe', email: 'user@email.com', password: '123456')
other_user = User.create(name: 'Meg Adeth', email: 'other.user@email.com', password: '123456')
another_user = User.create(name: 'Loren Ipsum', email: 'another.user@email.com', password: '123456')

sobremesa = RecipeType.create(name: 'Sobremesa')
salgado = RecipeType.create(name: 'Salgado')
entrada = RecipeType.create(name: 'Entrada')
petisco = RecipeType.create(name: 'Petisco')
massa = RecipeType.create(name: 'Massa')

brasileira = Cuisine.create(name: 'Brasileira')
italiana = Cuisine.create(name: 'Italiana')
portuguesa = Cuisine.create(name: 'Portuguesa')
japonesa = Cuisine.create(name: 'Japonesa')
francesa = Cuisine.create(name: 'Francesa')

Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
              recipe_type: sobremesa, cuisine: brasileira,
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                            misture com o restante dos ingredientes',
              user: user, status: 'accepted')

Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
              recipe_type: sobremesa, cuisine: brasileira,
              cook_time: 60, ingredients: 'Farinha, açucar, chocolate',
              cook_method: 'Cozinhe a chocolate, corte em pedaços pequenos,\
                            misture com o restante dos ingredientes',
              user: user, status: 'accepted')

Recipe.create(title: 'Bolo de Laranja', difficulty: 'Fácil',
              recipe_type: sobremesa, cuisine: portuguesa,
              cook_time: 45, ingredients: 'Farinha, açucar, laranja',
              cook_method: 'Cozinhe a laranja, corte em pedaços pequenos,\
                            misture com o restante dos ingredientes',
              user: other_user, status: 'pending')
  
Recipe.create(title: 'Petit Gateau', difficulty: 'Dificil',
              recipe_type: sobremesa, cuisine: italiana,
              cook_time: 50, ingredients: 'Farinha, açucar, chocolate, sorvete',
              cook_method: 'Misture tudo, asse, recheie e,\
                            misture com o restante dos ingredientes',
              user: other_user, status: 'accepted')

Recipe.create(title: 'Coxinha', difficulty: 'Dificil',
              recipe_type: petisco, cuisine: brasileira,
              cook_time: 70, ingredients: 'Frango desfiado, ovo, farinha, batata',
              cook_method: 'Misture tudo, recheie,\
                            empane e frite',
              user: other_user, status: 'accepted')

