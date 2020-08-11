using Images


function im2arr(im_path)
    im = load(im_path)
    im_float_arr = permutedims(channelview(im), (2, 3, 1))
    im_float_arr = Float64.(im_float_arr)
    return im_float_arr
end

function color_balance(im_arr, r, g, b)
    im_arr_cpy = copy(im_arr)

    im_arr_cpy[:, :, 1] = im_arr_cpy[:, :, 1] .+ r
    im_arr_cpy[:, :, 2] = im_arr_cpy[:, :, 2] .+ g
    im_arr_cpy[:, :, 3] = im_arr_cpy[:, :, 3] .+ b

    im_arr_cpy = clamp.(im_arr_cpy, 0, 255)
    return im_arr_cpy
end

function adjust_brightness(im_paths, factor)
    for im_path in im_paths
        im_arr = im2arr(im_path)
        color_balance(im_arr, factor, factor, factor)
    end
end