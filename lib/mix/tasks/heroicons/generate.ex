defmodule Mix.Tasks.Heroicons.Generate do
  use Mix.Task

  @shortdoc "To run `mix heroicons.generate`. Converts source SVG files into heex components."
  def run(_) do
    System.cmd("git", ["clone", "https://github.com/tailwindlabs/heroicons.git"])
    Enum.each(["outline", "solid"], &loop_directory/1)
    Enum.each(["solid"], &loop_mini_directory/1)
    Mix.Task.run("format")
    System.cmd("rm", ["-rf", "heroicons"])
  end

  defp loop_directory(folder) do
    src_path = "./heroicons/optimized/24/#{folder}/"
    namespace = "Heroicons.#{String.capitalize(folder)}"

    file_content = """
    defmodule PetalComponents.#{namespace} do
      @moduledoc \"\"\"
      Icon name can be the function or passed in as a type eg.

          <PetalComponents.Heroicons.Solid.home class="w-5 h-5" />
          <PetalComponents.Heroicons.Solid.home title="Optional title for accessibility" class="w-5 h-5" />
          <PetalComponents.Heroicons.Solid.render icon="home" class="w-5 h-5" />

          <PetalComponents.Heroicons.Outline.home class="w-6 h-6" />
          <PetalComponents.Heroicons.Outline.home title="Optional title for accessibility" class="w-6 h-6" />
          <PetalComponents.Heroicons.Outline.render icon="home" class="w-6 h-6" />
      \"\"\"
      use Phoenix.Component

      alias PetalComponents.Svg

      def render(%{icon: icon_name} = assigns) when is_atom(icon_name) do
        apply(__MODULE__, icon_name, [assigns])
      end

      def render(%{icon: icon_name} = assigns) do
        icon_name =
          icon_name
          |> String.replace("-", "_")
          |> String.to_existing_atom()

        apply(__MODULE__, icon_name, [assigns])
      end
    """

    functions_content =
      src_path
      |> File.ls!()
      |> Enum.filter(&(Path.extname(&1) == ".svg"))
      |> Enum.sort()
      |> Enum.map(&create_component(src_path, &1, folder))
      |> Enum.join("\n\n")

    file_content =
      file_content <>
        """
          # coveralls-ignore-start
        """ <>
        functions_content <>
        """
          # coveralls-ignore-stop
        end
        """

    dest_path = "./lib/petal_components/icons/heroicons/#{folder}.ex"

    unless File.exists?(dest_path) do
      File.mkdir_p("./lib/petal_components/icons/heroicons")
    end

    File.write!(dest_path, file_content)
  end

  defp loop_mini_directory(folder) do
    src_path = "./heroicons/optimized/20/#{folder}/"
    namespace = "Heroicons.#{String.capitalize(folder)}"

    file_content = """
    defmodule PetalComponents.Mini.#{namespace} do
      @moduledoc \"\"\"
      Icon name can be the function or passed in as a type eg.

          <PetalComponents.Heroicons.Mini.Solid.home class="w-5 h-5" />
          <PetalComponents.Heroicons.Mini.Solid.home title="Optional title for accessibility" class="w-5 h-5" />
          <PetalComponents.Heroicons.Mini.Solid.render icon="home" class="w-5 h-5" />

          <PetalComponents.Heroicons.Mini.Outline.home class="w-6 h-6" />
          <PetalComponents.Heroicons.Mini.Outline.home title="Optional title for accessibility" class="w-6 h-6" />
          <PetalComponents.Heroicons.Mini.Outline.render icon="home" class="w-6 h-6" />
      \"\"\"
      use Phoenix.Component

      alias PetalComponents.Svg

      def render(%{icon: icon_name} = assigns) when is_atom(icon_name) do
        apply(__MODULE__, icon_name, [assigns])
      end

      def render(%{icon: icon_name} = assigns) do
        icon_name =
          icon_name
          |> String.replace("-", "_")
          |> String.to_existing_atom()

        apply(__MODULE__, icon_name, [assigns])
      end
    """

    functions_content =
      src_path
      |> File.ls!()
      |> Enum.filter(&(Path.extname(&1) == ".svg"))
      |> Enum.sort()
      |> Enum.map(&create_component(src_path, &1, folder))
      |> Enum.join("\n\n")

    file_content =
      file_content <>
        """
          # coveralls-ignore-start
        """ <>
        functions_content <>
        """
          # coveralls-ignore-stop
        end
        """

    dest_path = "./lib/petal_components/icons/heroicons/mini/#{folder}.ex"

    unless File.exists?(dest_path) do
      File.mkdir_p("./lib/petal_components/icons/heroicons/mini")
    end

    File.write!(dest_path, file_content)
  end

  defp create_component(src_path, filename, type) do
    svg_content =
      File.read!(Path.join(src_path, filename))
      |> String.trim()
      |> String.replace(~r/<svg /, "<svg class={@class} {@rest} ")
      |> String.replace(~r/(\A.*)/, "\\g{1}\n    <Svg.title title={@title} />")
      |> String.replace(~r/<path/, "  <path")

    build_component(filename, svg_content, type)
  end

  defp function_name(current_filename) do
    current_filename
    |> Path.basename(".svg")
    |> String.replace("-", "_")
  end

  defp build_component(filename, svg, type) do
    class = class_for(type)

    """
    def #{function_name(filename)}(assigns) do
      assigns = assigns
        |> assign_new(:title, fn -> nil end)
        |> assign_new(:class, fn -> "#{class}" end)
        |> assign_new(:rest, fn ->
          assigns_to_attributes(assigns, ~w(
            class
          )a)
        end)

      ~H\"\"\"
      #{svg}
      \"\"\"
    end
    """
  end

  defp class_for("outline"), do: "h-6 w-6"
  defp class_for("solid"), do: "h-5 w-5"
end
