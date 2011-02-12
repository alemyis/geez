# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

misale1 = Misale.create(:head => "ለእግሩ የተጠየፈ", :tail => 'ለመቀመጫው ተረፈ', :illustration => 'http://www.acclaimimages.com/_gallery/_images_n300/0041-0909-2806-1147_illustration_worker_taking_a_slip_and_fall.jpg')
misale2 = Misale.create(:head => 'አልጠግብ ባይ', :tail => 'ሲተፋ ያድራል', :illustration => 'http://image.shutterstock.com/display_pic_with_logo/70895/70895,1160512196,5/stock-photo-cartoon-illustration-of-greedy-mouse-eating-sausage-1977948.jpg')
misale3 = Misale.create(:head => 'የራሷ እያረረ', :tail => 'የጎረቤት ታማስላለች', :illustration => 'http://tigrepelvar2.files.wordpress.com/2008/10/cartoon20081002.jpg')
misale4 = Misale.create(:head => 'ጅብ የማያውቁት አገር ሄዶ', :tail => 'ቁርበት አንጥፉልኝ ይላል', :illustration => 'http://images.quickblogcast.com/17123-16365/640RescuedMortgageCartoonWasserman2007.jpg')
misale5 = Misale.create(:head => 'ያላዋቂ ሳሚ', :tail => 'ንፍጥ ይለቀልቃል', :illustration => 'http://1.bp.blogspot.com/_k0ZCGYyFfCg/Seynn9SrRvI/AAAAAAAAAY8/GyteRTIjtNk/s400/palin+cartoon+lipstick.jpg')

misale6 = Misale.create(:head => 'ሰው ጥራ ቢሉት', :tail => 'እራሱ መጣ', :illustration => 'http://4.bp.blogspot.com/_uysYaf3Oi-I/TJn-b9xdb8I/AAAAAAAAB4w/GpK1_Vw5irI/s320/Pointing_Finger.jpg')
misale7 = Misale.create(:head => 'የአናጺ ቤት', :tail => 'በሩ ሰባራ ነው', :illustration => 'http://t0.gstatic.com/images?q=tbn:ANd9GcTi6eZEUOpGqKM7hElTcMNXDKtIvXKKOeQCyxVlMeUa0o_wLLj2Bw')
misale8 = Misale.create(:head => 'የፉክክር ቤት', :tail => 'ሳይዘጋ ያድራል', :illustration => 'http://t2.gstatic.com/images?q=tbn:ANd9GcSqLii0BXgEDiB4YEEljbA59KbeuwnzM6kbfc92K7FnzQAJjpEa')
misale9 = Misale.create(:head => 'ላለፈ ክረምት', :tail => 'ቤት አይሰራም', :illustration => 'http://www.corbisimages.com/images/67/9B576AF5-7A9F-4BEB-85F4-61969841C05E/42-18733979.jpg')
misale10 = Misale.create(:head => 'ጽድቅና ኩነኔ ቢኖርም ባይኖርም', :tail => 'ከክፋት ደግነት ሳይሻል አይቅርም', :illustration => 'http://www.videoclipart.com/GOOD_EVIL2.jpg')


challenge1 = Challenge.create(:name => 'ሳምንት 1', :note => 'የሳምንት 1 ጥያቄዎች')
challenge2 = Challenge.create(:name => 'ሳምንት 2', :note => 'የሳምንት 2 ጥያቄዎች')

categorization1 = Categorization.create(:misale_id => misale1.id, :challenge_id => challenge1.id,:position => 1)
categorization2 = Categorization.create(:misale_id => misale2.id, :challenge_id => challenge1.id,:position => 2)
categorization3 = Categorization.create(:misale_id => misale3.id, :challenge_id => challenge1.id,:position => 3)
categorization4 = Categorization.create(:misale_id => misale4.id, :challenge_id => challenge1.id,:position => 4)
categorization5 = Categorization.create(:misale_id => misale5.id, :challenge_id => challenge1.id,:position => 5)

categorization6 = Categorization.create(:misale_id => misale6.id, :challenge_id => challenge2.id,:position => 1)
categorization7 = Categorization.create(:misale_id => misale7.id, :challenge_id => challenge2.id,:position => 2)
categorization8 = Categorization.create(:misale_id => misale8.id, :challenge_id => challenge2.id,:position => 3)
categorization9 = Categorization.create(:misale_id => misale9.id, :challenge_id => challenge2.id,:position => 4)
categorization10 = Categorization.create(:misale_id => misale10.id, :challenge_id => challenge2.id,:position => 5)


comment1_1 = Comment.create(:nickname => 'Alex', :email => 'alemyis@gmail.com', :phone => 12341234, :comment =>'orem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tortor erat, aliquam sed dignissim non, vestibulum sit amet eros. Duis a nisl lacus. Nunc condimentum nulla nec libero varius posuere imperdiet mi auctor. Aenean convallis sem id augue dictum ornare. Etiam elementum facilisis purus ut tincidunt.', :misale_id => misale1.id)
comment1_2 = Comment.create(:nickname => 'Alex', :email => 'alemyis@gmail.com', :phone => 12341234, :comment =>'orem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tortor erat, aliquam sed dignissim non, vestibulum sit amet eros. Duis a nisl lacus. Nunc condimentum nulla nec libero varius posuere imperdiet mi auctor. Aenean convallis sem id augue dictum ornare. Etiam elementum facilisis purus ut tincidunt.', :misale_id => misale1.id)
comment1_3 = Comment.create(:nickname => 'Alex', :email => 'alemyis@gmail.com', :phone => 12341234, :comment =>'orem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tortor erat, aliquam sed dignissim non, vestibulum sit amet eros. Duis a nisl lacus. Nunc condimentum nulla nec libero varius posuere imperdiet mi auctor. Aenean convallis sem id augue dictum ornare. Etiam elementum facilisis purus ut tincidunt.', :misale_id => misale1.id)

comment2_1 = Comment.create(:nickname => 'Alex', :email => 'alemyis@gmail.com', :phone => 12341234, :comment =>'orem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tortor erat, aliquam sed dignissim non, vestibulum sit amet eros. Duis a nisl lacus. Nunc condimentum nulla nec libero varius posuere imperdiet mi auctor. Aenean convallis sem id augue dictum ornare. Etiam elementum facilisis purus ut tincidunt.', :misale_id => misale2.id)
comment2_2 = Comment.create(:nickname => 'Alex', :email => 'alemyis@gmail.com', :phone => 12341234, :comment =>'orem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tortor erat, aliquam sed dignissim non, vestibulum sit amet eros. Duis a nisl lacus. Nunc condimentum nulla nec libero varius posuere imperdiet mi auctor. Aenean convallis sem id augue dictum ornare. Etiam elementum facilisis purus ut tincidunt.', :misale_id => misale2.id)

comment3_1 = Comment.create(:nickname => 'Alex', :email => 'alemyis@gmail.com', :phone => 12341234, :comment =>'orem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tortor erat, aliquam sed dignissim non, vestibulum sit amet eros. Duis a nisl lacus. Nunc condimentum nulla nec libero varius posuere imperdiet mi auctor. Aenean convallis sem id augue dictum ornare. Etiam elementum facilisis purus ut tincidunt.', :misale_id => misale3.id)
