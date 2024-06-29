# Private Events

This is a private events application built with Ruby on Rails. Users can create events, attend events, and see a list of past and upcoming events.

## Features
- User authentication with Devise
- Event creation and management
- Event attendance tracking
- Filtering events by past and upcoming

[Link to Odin Project Assignment](https://www.theodinproject.com/lessons/ruby-on-rails-private-events)


# Running the app

To set up the app on a new computer for development, follow these steps:

1. Clone the repository:
```bash
git clone https://github.com/cyberracc/private_events_rails.git
```

2. Install the required gems:
```bash
bundle install
```

3. Install Yarn:
```bash
npm install --global yarn
```

4. Install the required Node.js LTS version:
```bash
nvm install --lts
```

5. Set the installed Node.js LTS version as the default:
```bash
nvm use --lts
```

6. Install the project dependencies:
```bash
yarn install
```

7. Migrate the database:
```bash
rails db:migrate
```

8. Seed the database:
```bash
rails db:seed
```

9. Start the development server and the CSS build process:
```bash
bin/dev
```

Make sure to execute these commands from the project root directory.


# Fixing Tailwind CSS and DaisyUI Integration in Rails 7.1 without CDN

## Issue
The issue was integrating DaisyUI with Tailwind CSS in a Rails 7.1 application without using a CDN. The initial setup didn't work correctly due to missing configurations and dependencies.

## Resolution Steps

> Note that you must also verify that the `tailwind.config.js` file is in `app/config` **only**! If it is in `app/config` *and* in the root `app` folder, DaisyUI will not function correctly.

### 1. Install Bundling Gems
Ensure the necessary bundling gems are installed:
```bash
bundle add jsbundling-rails cssbundling-rails
```

### 2. Set Up Tailwind and DaisyUI
Run the setup commands for Tailwind:
```bash
rails css:install:tailwind
yarn add daisyui @tailwindcss/forms @tailwindcss/typography @tailwindcss/container-queries
```

### 3. Update Tailwind Configuration
Ensure your `tailwind.config.js` includes the required plugins:
```js
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('daisyui'),
  ]
}
```

### 4. Ensure PostCSS Configuration
Make sure your `postcss.config.js` includes the required plugins:
```js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
```

### 5. Verify Application CSS
Verify your `application.tailwind.css` contains the Tailwind directives:
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### 6. Create `Procfile.dev`
Create a `Procfile.dev` to run both Rails and the CSS build process:
```procfile
web: bin/rails server
css: yarn build:css --watch
```

### 7. Start Development
Run your development server with Foreman to watch for CSS changes:
```bash
bin/dev
```

## Testing the Setup

### Adding a DaisyUI Component
To test if DaisyUI is working, add a simple DaisyUI component to one of your views:
```erb
<div class="btn btn-primary">
  Test Button
</div>
```
Visit the view in your browser and ensure the button is styled correctly.

### Check Browser Console
Open the browser's developer console to check for any CSS or JavaScript errors.

### View Source
Verify that the compiled CSS includes styles from both Tailwind CSS and DaisyUI by viewing the source of the generated `application.css`.

This setup should resolve the integration issues and allow you to use Tailwind CSS and DaisyUI correctly in your Rails application.