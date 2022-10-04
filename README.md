
<img src="https://res.cloudinary.com/metamorphic/image/upload/v1664900186/Logo/MossPiglet_Horizontal_OnLight_zszpdn.png" alt="Moss Piglet logo" />

## Heroicons Render

<p align="center">
  <a href="https://hex.pm/packages/heroicons_render">
    <img alt="Hex Version" src="https://img.shields.io/hexpm/v/heroicons_render.svg">
  </a>
  <a href="https://hex.pm/packages/heroicons_render">
    <img alt="Hex Downloads" src="https://img.shields.io/hexpm/dt/heroicons_render.svg?style=flat">
  </a>
  <a href="https://hexdocs.pm/heroicons_render">
    <img alt="Hex Docs" src="https://img.shields.io/badge/hex-docs-green.svg?style=flat">
  </a>
  <a href="https://opensource.org/licenses/MIT" alt="MIT">
    <img src="https://img.shields.io/badge/license-MIT-green" />
  </a>
</p>
  
Heroicons Render is a modified version of the HeroiconsV1 from the wonderful Petal Components. This is to enable calling the render function from Petal Components with Heroicons version 2. You can use this library in conjuction with Petal Components and Heroicons.

## About the Petal Components library

<p align="center">
  <a href="https://hex.pm/packages/petal_components">
    <img alt="Hex Version" src="https://img.shields.io/hexpm/v/petal_components.svg">
  </a>
  <a href="https://hexdocs.pm/petal_components">
    <img alt="Hex Docs" src="https://img.shields.io/hexpm/dt/petal_components.svg?style=flat">
  </a>
  <a href="https://opensource.org/licenses/MIT" alt="MIT">
    <img src="https://img.shields.io/badge/license-MIT-green" />
  </a>
  <a href="https://codecov.io/gh/petalframework/petal_components" >
    <img src="https://codecov.io/gh/petalframework/petal_components/branch/main/graph/badge.svg?token=47KQGJOT1G"/>
  </a>
</p>

<p align="center">
  <a href="https://petal-components-demo.fly.dev">
    <img src="https://res.cloudinary.com/wickedsites/image/upload/c_scale,h_621/v1646543077/petal/demo_nmw8eh.png" height="300" />
  </a>
  <a href="https://petal-components-demo.fly.dev">
    <img src="https://res.cloudinary.com/wickedsites/image/upload/c_scale,h_621/v1646543453/petal/demo-light_sijqjy.png" height="300" />
  </a>
</p>

<p align="center">
  <a href="https://petal-components-demo.fly.dev">DEMO</a> | <a href="https://petal.build/components">DOCS</a>
</p>

Petal stands for:

* [Phoenix](https://www.phoenixframework.org/)
* [Elixir](https://elixir-lang.org/)
* [Tailwind CSS](https://tailwindcss.com/)
* [Alpine JS](https://alpinejs.dev/) (optional)
* [Live View (HEEX)](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)

## Dependencies

This package requires [Live View 0.18](https://hex.pm/packages/phoenix_live_view) and [Phoenix 1.6](https://hex.pm/packages/phoenix).

It also requires Elixir 1.12 to work. It is designed to supplement the [Petal Components](https://hex.pm/packages/petal_components) and [Heroicons](https://hex.pm/packages/heroicons) libraries. If you are are not using those libraries, then there is really no reason to use this. This library plugs a hole where you could not implement the icon `render` function from Petal Components with v2 Heroicons.

## Install

**Recommended**

This package can be installed by adding `:heroicons_render` to your list of dependencies in `mix.exs`:

```elixir
defp deps do
  [
    ...
    {:heroicons_render, "~> 0.1.1"},
  ]
end
```

Then, run `mix deps.get`. Additionally, run `mix deps.update heroicons_render` occasionally to ensure you have the latest release.

**Running on main**

If you would like to run on the main branch, then update your dependencies as such:

```elixir
defp deps do
  [
    ...
    {:heroicons_render, github: "/moss-piglet/heroicons_render"},
  ]
end
```

## Usage

You can use the render function the same as you would in the Petal Components library, e.g. by calling:

```elixir
## Petal Components
<HeroiconsV1.Solid.render icon="document_text" />

## Heroicons Render
<HeroiconsV2.Solid.render icon="document_text" />
```

You may need to add the following to your Phoenix app:

```elixir
defmodule MyAppWeb do
  ...
  use PetalComponents
  use HeroiconsRender # add this
  ...
end

# In any files that has PetalComponents you might need to also add HeroiconsRender
use PetalComponents
use HeroiconsRender # add this
```

Then to call Heroicons version 2 icons, you can use the Heroicons library function call:

```elixir
<Heroicons.map outline class="some classes" />
```

This enables you to use the Petal Components library and Heroicons library and have your components use version 2 of Heroicons without conflict.