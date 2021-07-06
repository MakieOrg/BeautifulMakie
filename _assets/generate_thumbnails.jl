using Glob, Images
let
    files = glob("./scripts/output/*.png")
    for i in 1:length(files)
        img_source = load(files[i])
        if size(img_source)[1] <700 || size(img_source)[2] <700
            percentage_scale = 0.6
        else
            percentage_scale = 0.33
        end
        new_size = trunc.(Int, size(img_source) .* percentage_scale)
        img_rescaled = imresize(img_source, new_size)
        save("./thumbnails/"*files[i][18:end-4]* "_thumb"*".png", img_rescaled)
    end
end
