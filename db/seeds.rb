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
americana = Cuisine.create(name: 'Americana')

Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
              recipe_type: sobremesa, cuisine: brasileira,
              cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                            misture com o restante dos ingredientes',
              user: user, status: 'accepted',
              image_url: 'https://cdn.pixabay.com/photo/2018/05/20/15/45/cake-3416079_960_720.jpg')

Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
              recipe_type: sobremesa, cuisine: brasileira,
              cook_time: 60, ingredients: 'Farinha, açucar, chocolate',
              cook_method: 'Cozinhe a chocolate, corte em pedaços pequenos,\
                            misture com o restante dos ingredientes',
              user: user, status: 'accepted',
              image_url: 'https://cdn.pixabay.com/photo/2017/03/07/04/41/swede-cakes-2123192_960_720.jpg')

Recipe.create(title: 'Bolo de Laranja', difficulty: 'Fácil',
              recipe_type: sobremesa, cuisine: portuguesa,
              cook_time: 45, ingredients: 'Farinha, açucar, laranja',
              cook_method: 'Cozinhe a laranja, corte em pedaços pequenos,\
                            misture com o restante dos ingredientes',
              user: other_user, status: 'pending',
              image_url: 'https://cdn.pixabay.com/photo/2019/01/06/13/37/kitchen-3917004_960_720.jpg')
  
Recipe.create(title: 'Petit Gateau', difficulty: 'Dificil',
              recipe_type: sobremesa, cuisine: italiana,
              cook_time: 50, ingredients: 'Farinha, açucar, chocolate, sorvete',
              cook_method: 'Misture tudo, asse, recheie e,\
                            misture com o restante dos ingredientes',
              user: other_user, status: 'accepted',
              image_url: 'https://cdn.pixabay.com/photo/2017/06/23/16/54/petit-gateau-2435264_960_720.jpg')

Recipe.create(title: 'Coxinha', difficulty: 'Dificil',
              recipe_type: petisco, cuisine: brasileira,
              cook_time: 70, ingredients: 'Frango desfiado, ovo, farinha, batata',
              cook_method: 'Misture tudo, recheie,\
                            empane e frite',
              user: other_user, status: 'accepted',
              image_url: 'https://cdn.pixabay.com/photo/2019/04/27/23/07/coxinha-4161592_960_720.jpg')

Recipe.create(title: 'Biscoito de Gengibre', difficulty: 'Dificil',
                recipe_type: petisco, cuisine: americana,
                cook_time: 70, ingredients: 'Farinha, gengibre em pó, açúcar refinado, açúcar mascavo, manteiga, ovos, fermento em pó',
                cook_method: 'Misture tudo, corte no formato desejado, asse no forno a 180 graus por cerca de 30 minutos',
                user: other_user, status: 'accepted',
                image_url: 'https://cdn.pixabay.com/photo/2016/12/06/15/26/christmas-cookies-1886760_960_720.jpg')

