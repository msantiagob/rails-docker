# Usa la imagen base de Ruby 3.3.3
FROM ruby:3.3.3

# Instala dependencias necesarias
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Crea el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo Gemfile y Gemfile.lock al contenedor
COPY Gemfile Gemfile.lock /app/

# Instala las gemas necesarias
RUN gem install bundler && bundle install

# Copia el resto del código de la aplicación al contenedor
COPY . /app

ARG DATABASE_URL

ENV DATABASE_URL=${DATABASE_URL}

# Expone el puerto 3000 para que la aplicación sea accesible
EXPOSE 3000

# Comando para iniciar el servidor de Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
