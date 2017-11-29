#<center>  Instagrid
----------
Instagrid iOS app has been developped for Open Classrooms on iOS dev in swift 4.0.

### Installing

clone the repository on your local machine and open Xcode and then build the project.
###Supported plateforms
Iphone & ipad (portrait only)
### Concept
This application allow the user to choose images from :

1. photo library
2. take pictures with camera (Bonus 1)
3. search on `Pixabay` for images (Bonus 2)

You can find Pixabay RESTAPI Documentation
https://pixabay.com/api/docs/

Apply filters (based on CoreImages) (Bonus 3)on them:


-CIPhotoEffectNoir
-CIPhotoEffectChrome
-CIPhotoEffectInstant
-CIPhotoEffectTransfer
-CIPhotoEffectProcess
-CIPhotoEffectTonal
![enter image description here](https://lh3.googleusercontent.com/YCu4mXZrRBxOf0yXXOyYC35FccIu4QDGc4HAjxdN4GZXeiwumSbEdu7UXV6r3-QdDGsL8zsu4Bn1EoaHlsjMxL60BocDt3VDy0sBcYQqJ5DA9s2zLxsVLv_uLOczDKZX1zv5HvLSZFwcupfuFgY-uoGf51yQ2y3WdnrRcU_l-Jb01hu5m6zZ5LFL6YrwGuJCutL0LnbpeJ3qxNDzMVKZ9rVMMat5paOPDe5_Tj7600j7Ip_wK_5jafXSAIDSWpo838KwFlUmaQ5WgPaUYA9-SL2TUPYGo6JOxFjBPLMPDNkkTHIs7szNp9sRrRZMfLETpExUKNgUtN7qOaRgroBeOaGMZptHSNPsNhradbbQ-tqp9FbI-vLVoXUDmrS9-rA7Zzj-H4svttVEmE4tkFjD9iJsq-ErynuIWYZG8Pc2rzCwCj0H9CtV4-Rj7HkIPBngkkIWCvtyaB9-OCw_NA-mLomRXKVhT3PP86fgAUDAIHqq6QIi-7y8UyWH9Vz-N_-ICAcqYJlZgoHh_D2mWgYhXJGH9GCrQ2XGbXgL4BDU-OXyHbcTVrQb29EdUzw8gJS12c-DOUb1P_rEMV-bodWcAdYo5p_6tWUsyT0ta9IIjQ=w415-h737-no)
and create a collage with 3 differents layouts
![enter image description here](https://lh3.googleusercontent.com/Ht7UqvWI-NaZqfPkji1DiPdoQs0GBjsQVMJzx0K3vTQ2KgE55AD_4TtUvcnxuNxMajIUO9RqRoMken3vr5B4JI2ZJZAtLGZMUQ9kaqECAbGpawc570pF0jZU8fCRsdN-9i_CHFRBwcwFVMJXUP1PG11JjKOd6z4QY-KqSLZ7cg_Z8y6GIlfQNy2Zlw4mJ1xpytDLaGUZ3CeerLGblXs-Zdf_8SQQkS5oHTBZ-sbSkXARpvlUO_sQwEpAo4ktRwEdeGdBZzjHQi1pjh4LWvUotaCjfj24fjkQW_KoalQC7va05pOoL1dM6rJg96QPIVCnOVsYKZmXAYRmILo-fEU1W_so7_Itrd8OXD40nxQf9DVtIjEJq9JUlY5g_pvEpNyWmobRvbYtHsfdBVx8t-I6p3cWmTKvQPKxV7A0LMYkaAEV0SdpWlMUYAzZJCiDd_3m5PRyZOwiJe98_G32sOEe2JO0x-NJjLPxah9JXKChAgN6oGLfKMCfc4nL3jGDrex0ZtB77tyLHrH7Bv5rp4N58FfShwSVSgHPwQvdF_rq7aWQZXQuLe8Jm-vDW-O9Q8ex27QhDx1JUFGyQFX1y98cRLlGrZUtuuXuTTAiaj_muhRlOKvdnJBHj9ENGmPZYHq_NL7nqSDOF2UJlBfruZ91ob4yp52n2glICvY=w413-h732-no)
and share it mail, social apps, sms or save it via a UIActivityController
![enter image description here](https://lh3.googleusercontent.com/adF9QwEpBjMFEiKZ8C_O4hdF2pNUhI_OCvq_9ngAamllzSz8heXseE2f03E8RBNKez1D1xGSa4mgXDgE9iY6iEkx3qwfkPjFEU2e8885juENq9NK0CQSkaquWOGNSJd2EN2pAx7H36kiTG4bMy0rIWE6QEzB3uMBhdx5oBZVmJXi-r_61bBw5q55TDXMUED7BCRkwoBkq57nz3newEz3rsXk1l5EeblaKyTqRmp5zNcBAdndpEMIQLpJly11xxfMXIl1Exvv8mGC2mguuI-NgFw77Gvpq_pjWecqUaWkOSBklTMl7jiJ6G2pYOrPf_rH9rwjVqbIMhAsBl6qT1bTzkXzJdLma01-5x_ocm4OOcJG-aUds2wHqMGPoPIG8XnYdfDMYK8cH6paJUJnFipSpW6PGPfaX3WDLEHGYXvQlqgsCdpE910-gVHV-SyILfUOHB6PLV9p7w4v0MzoyRIpeA_8EC7W-e5cEPfBwC5vzCVX31lISGx5TZOmNADyehRQeki-slt5tWA97N9xhIOL3_ygCJfPRgy5UKH2cr1JW3NQo3n4EqriUvcz3zR8UcQcJvlTa9L3JC814Grm7n-tV-LnzD4gpQeFqpwDeuwfnw=w408-h734-no)
### Take Picture
We use the same image picker and set up a function that checks if there is a camera or not.

### Ipad Compatibility Bonus
Special constraints have been done.

The UIImagePicker has to be presented in popover and not modally.
We had to check the device to apply the choice

if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
if let PopOver = controller.popoverPresentationController {
PopOver.sourceView = self.view
}
present( controller, animated: true, completion: nil )
//print("ipad")
} else{
//print("iphone")
present(controller, animated: true){
}
}
}

For the landscape orientation a function has been to design to get the correct orientation
first we check orientation

if UIDevice.current.orientation.isLandscape {
landscapeOrientation = true
print("Landscape")
} else{
print("Portrait")
landscapeOrientation = false
}

and then we force the orientation


let landscapeRawValue = UIInterfaceOrientation.landscapeLeft.rawValue
UIDevice.current.setValue(landscapeRawValue, forKey: "orientation")
![enter image description here](https://lh3.googleusercontent.com/lElCqUqiFVK6_SrsR_BZalcui81zk8VBaiUkk4Tdxq8_-uYO0-xJs748i49F6m9DdcjbNp_rNrm9JKF3nrfZ4VE83hQ0lCRV74UJ2ZQonjbk_PCSCy3NEouLGfncR5USOeXb__B1GkQi4d3jZD0-j_TCyENZWZIglxuCNZkefQ9NQYOAJWEb6_KcYRlUWbKC7zTmY1VULyO0mVmAJyVs82RJFz4o6D-6Dahf34UkeUC7I7FMP-3mt6H9AhmEygnyUjrZ-ghV0HX06SehPbBoLyXBUpDI8cfBwDGvBcENEeQfnLTGRa7kuXdYhFaGu6gL5ygTTuYtDWv_HgDmfC71ctvkqndW6WFEoDKiANIqB_wjnJJTmDPyJ8_14AGnD2VDV2fmHpYmbfruPVl4HUh4LScr9RGbZgrgS3c05TYXqcrce9grV97njDYXyX0sV0Zd0ntQEmjI-c01f5C0fJeStzKnnY_wYP94vsEDSJXO71rn0y2Wj20gRqvfhlOLUBJJgUVACE0Z2npY_6xkEztzUGwMz8YMSMrnC68PwHdJ3FLcDSo8uKFAPwdYjWwyKKUdCc3MQAfbf-ccp8x4arkkR13es508wZJQ0QBLi6-wZw=w489-h276-no)

### WebSearch Bonus
You enter a query in the text input field and trigger the search by pressing search button

We have set :

1. An APIClient Model
2. An object model for answer
3. Set up a CollectionView

The search is displayed on a separate UICollectionViewController. You add the image to the collage when tapping on the image

![enter image description here](https://lh3.googleusercontent.com/uLHkSonf7_k73o185NB0Ir433I8SC_du9kaGjK5cGaYypN5beYX-w5lQYPyMbetCDapri6DEyZMv8rrqz-ymcZ8jw_A73hZSHOrwIZCCebj0Sf6GLFK04J0TDwxsSqyhisNjkqRj9JF1rZ241Q0RURdhge1jrbarercG_B2xlBS3CxX5evnPToTpf95a8cZfjV7T7cEtnVn1Y5iXDZAkGF5msoyf4n7yXHVfwTm-suaUVVf2CVkVrqcSD9o2ZpSUtSLPcTc5_szZMLoN0wvlIxYYk6-uB12B3ANH4lvEONSwj7Vnz9YIVg1kacegnYp3nae8NzVgX1XtpWzsdTrkPhgrO4eR1YFbsNj0kqgSZFTScCcEOfWQtadAL2VINiXyBDHasNKesncRUydXrBm4JCCdggNctPydRTZzWfOYkBvmc-PkhX2fd63CcmP_q8KvfAO28E_uaaJK23g2A2DdGgyjoG9LQR8BgsBqd9hwkfn2UGYVXhMW3nLFItn2bQZ1SFiIYK8KPuThsyHe1hiIATmN8qK94UCsYvClsIT3gxsP6wV8yVYy_5SqHy3HVC4i60MZOzIukV4x7Fr4keLnNRRxZLOfAom8TcJR_rie0g=w407-h736-no)


