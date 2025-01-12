function gen_nav(files)
    categories = _categories(files)
    nav = OrderedDict[]
    # Add 2D and 3D categories directly
    cat_dict = OrderedDict[]
    for main_cat in ["2d", "3d"]
    if haskey(categories, main_cat)
        cat_dict = OrderedDict(
            "text" => uppercase(main_cat),
            "items" => []
        )
        # Add subcategories
        for (subcat, files) in categories[main_cat]
            # Use first file as default link
            default_file = first(files)
            push!(cat_dict["items"], OrderedDict(
                "text" => subcat,
                "link" => "/examples/$main_cat/$subcat/$default_file"
            ))
        end
        # Sort subcategories
        sort!(cat_dict["items"], by = x -> x["text"])
    end
    push!(nav, cat_dict)
    end
    # Add Advanced category for everything else
    advanced_items = []
    for (main_cat, subcats) in categories
        if main_cat ∉ ["2d", "3d"]
            # Use first file in first subcategory as default link
            default_file = first(subcats)
            push!(advanced_items, OrderedDict(
                "text" => titlecase(join(split(main_cat, "_"), " ")),
                "link" => "/examples/$main_cat/$default_file"
            ))
        end
    end
    # Add Advanced category if there are items
    if !isempty(advanced_items)
        sort!(advanced_items, by = x -> x["text"])
        push!(nav, OrderedDict(
            "text" => "Advanced",
            "items" => advanced_items
        ))
    end
    return nav
end

function gen_sidebar(files)
    # Generate the categories structure
    categories = _categories(files)
    # Generate sidebar structure
    sidebar = Dict()
    # Process all categories for sidebar
    for (main_cat, subcats) in categories
        sidebar_path = "/examples/$main_cat/"
        # Initialize the main category in the sidebar
        sidebar[sidebar_path] = [Dict(
            "text" => join(split(main_cat, "_"), " "),
            "items" => []
        )]
        if isa(subcats, Dict)  # If the main category has subcategories
            for (subcat, files) in subcats
                subcat_dict = Dict(
                    "text" => join(split(subcat, "_"), " "),
                    "collapsed" => true,
                    "items" => []
                )
                # Add all files in sorted order
                for file in sort(files)
                    push!(subcat_dict["items"], Dict(
                        "text" => join(split(file, "_"), " "),
                        "link" => "/examples/$main_cat/$subcat/$file"
                    ))
                end
                # Append subcategory to main category's items
                push!(sidebar[sidebar_path][1]["items"], subcat_dict)
            end
            # Sort subcategories in the main category
            sort!(sidebar[sidebar_path][1]["items"], by = x -> x["text"])
        elseif isa(subcats, Vector)  # If the main category has no subcategories
            for file in sort(subcats)
                push!(sidebar[sidebar_path][1]["items"], Dict(
                    "text" => join(split(file, "_"), " "),
                    "link" => "/examples/$main_cat/$file"
                ))
            end
        end
    end
    return sidebar
end

function _categories(files)
    categories = Dict{String, Any}()
    for file in files
        parts = split(file, '/')
        main_cat = parts[1]
        filename = parts[end][1:end-3]  # Remove .jl extension
        if length(parts) == 3
            # Handle 3-level paths
            subcat = parts[2]
            # Initialize category if not exists
            if !haskey(categories, main_cat)
                categories[main_cat] = Dict{String, Vector{String}}()
            end
            # Initialize subcategory if not exists
            if !haskey(categories[main_cat], subcat)
                categories[main_cat][subcat] = String[]
            end
            push!(categories[main_cat][subcat], filename)
        elseif length(parts) == 2
            # Handle 2-level paths where the second part is the filename
            if !haskey(categories, main_cat)
                categories[main_cat] = String[]
            end
            push!(categories[main_cat], filename)
        else
            println("Skipping unsupported path format: ", file)
        end
    end
    return categories
end