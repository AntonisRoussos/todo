module UsersHelper
 
require 'net/smtp'
 
def sendactivationmail(email, name, id)
#   logger.debug "id: #{id}"
smtp = Net::SMTP.new('smtp.gmail.com', 587)
smtp.enable_starttls

smtp.start('localhost', 'antonioroussos', 'onlyar13', 'login') do |s|
hdr = "From: Antonis Roussos <antonioroussos@gmail.com>\n"
hdr += "To:"
hdr += name 
hdr += "<"
hdr += email
hdr += ">\n"
hdr += "Subject: e-mail confirmation\n\n"
hdr += url_for(:only_path => false, :protocol => 'http')
# hdr += "http://localhost:3000/user/activateuser/"
hdr += "/activateuser/"
msg = hdr + id.to_s

s.send_message(msg, 'antonioroussos@gmail.com', email)

end

end 

def sendpasswordmail(email, name, encryptedhash)
# logger.debug "id: #{id}"
smtp = Net::SMTP.new('smtp.gmail.com', 587)
smtp.enable_starttls

smtp.start('localhost', 'antonioroussos', 'onlyar12', 'login') do |s|
hdr = "From: Antonis Roussos <antonioroussos@gmail.com>\n"
hdr += "To:"
hdr += name 
hdr += "<"
hdr += email
hdr += ">\n"
#hdr += t(:Subject_password_reset_mail\n\n)
hdr += t(:Subject_password_reset_mail)
hdr += "\n\n"
hdr += url_for(:only_path => false, :protocol => 'http')
# hdr += "http://localhost:3000/user/activateuser/"
hdr += "/ResetPasswordRequest/"
# msg = hdr + id.to_s
msg = hdr +  encryptedhash.to_s

s.send_message(msg, 'antonioroussos@gmail.com', email)

end

end 



def gravatar_for(user, options = { :size => 150 })
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
end

def verified_password?(existinguserpassword)
    encrypted_existing_password = secure_hash("#{@user.salt}--#{existinguserpassword}")
    if @user.encrypted_password == encrypted_existing_password
        return true 
    else 
	return false
    end
end

def secure_hash(string)
      Digest::SHA2.hexdigest(string)
end

def updatepasswordfields(user)
    encrypted_hash = secure_hash("#{@user.salt}--#{Time.now.utc}")
    logger.debug("#{encrypted_hash}")
    @user.cryptopass = encrypted_hash[2,1] + encrypted_hash[13,1] + encrypted_hash[21,1] + encrypted_hash[22,1]
    @user.time_forgot_password = Time.now.utc
    if !@user.update_attributes(params[:user])
        flash[:success] = "Unexpected error."
	redirect_to @user
    end
    return encrypted_hash
end

end
