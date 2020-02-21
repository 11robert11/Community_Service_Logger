{"changed":true,"filter":false,"title":"users_controller.rb","tooltip":"/app/controllers/users_controller.rb","value":"class UsersController < ApplicationController\n  before_action :correct_user, only: [:show]\n\n  def show\n    @user = User.find(params[:id])\n    if @user.hours.any?\n      @hours = @user.hours.all\n    end\n  end\n  \n  \n  def new\n    @user = User.new\n  end\n  \n  def create\n    @user = User.new(user_params)\n    if @user.save # <-- assigns the activation_token and digest \n      #@user.send_activation_email\n      #flash[:info] = \"Please check your email to activate your account\"\n      #redirect_to root_url\n      #Use lower code until Mailer is fixed\n      @user.activate\n      log_in(@user)\n      redirect_to @user\n      @user.update_attribute(:level, determine_level(@user))\n      flash[:success] = \"Account Created and Activated\"\n    else\n      render 'new'\n    end\n  end\n  \n  def all_supervisors\n    @supervisors = Supervisor.where(activated: true)\n  end\n\n  private\n  \n  def user_params\n    params.require(:user).permit(:id, :first_name, :last_name, :email, :student_id, :grade, :password, :password_confirmation)\n  end\n  \n  private\n  \n  def correct_user\n    @user = User.find(params[:id]) \n    if logged_in?\n      if !current_user.admin?\n        if !current_user?(@user)\n          redirect_to(root_url)\n          #redirect_to 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', :overwrite_params => { :parm => 'foo' }\n        end\n      end\n    elsif supervisor_logged_in?\n      if !current_supervisor.admin?\n        redirect_to(root_url)\n      end\n    end\n  end\n  \n  def determine_level(user)\n    @user = user\n    time = Time.zone.now\n    cutoff = DateTime.new(0, 7, 22, 0, 0, 0)\n    lev = \"\"\n    if(time.strftime(\"%m\") < cutoff.strftime(\"%m\")) # Before July\n      if(time.strftime(\"%d\") < cutoff.strftime(\"%d\")) # Before the 22nd\n        if (@user.grade.to_i - time.strftime(\"%Y\").to_i == 0) # Senior\n          lev = \"Se\"\n        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 1) # Junior\n         lev = \"Ju\"\n        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 2) # Sophomore\n         lev = \"So\"\n        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 3) # Freshman\n         lev = \"Fr\"\n        else\n          lev = \"N/A\"\n        end\n      end\n    elsif(time.strftime(\"%m\") >= cutoff.strftime(\"%m\")) # During or after July\n      if(time.strftime(\"%d\")) >= cutoff.strftime(\"%d\") # During or after the 22nd\n        if (@user.grade.to_i - time.strftime(\"%Y\").to_i == 1) # Senior\n          lev = \"Se\"\n        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 2) # Junior\n          lev = \"Ju\"\n        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 3) # Sophomore\n          lev = \"So\"\n        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 4) # Freshman\n            lev = \"Fr\"\n        else\n          lev = \"N/A\"\n        end\n      end\n    else\n      lev = \"N/A\"\n    end\n    return lev\n  end\n      \n  \nend\n","undoManager":{"mark":46,"position":46,"stack":[[{"start":{"row":57,"column":5},"end":{"row":58,"column":0},"action":"insert","lines":["",""],"id":2},{"start":{"row":58,"column":0},"end":{"row":58,"column":2},"action":"insert","lines":["  "]},{"start":{"row":58,"column":2},"end":{"row":59,"column":0},"action":"insert","lines":["",""]},{"start":{"row":59,"column":0},"end":{"row":59,"column":2},"action":"insert","lines":["  "]},{"start":{"row":59,"column":2},"end":{"row":59,"column":3},"action":"insert","lines":["d"]},{"start":{"row":59,"column":3},"end":{"row":59,"column":4},"action":"insert","lines":["e"]},{"start":{"row":59,"column":4},"end":{"row":59,"column":5},"action":"insert","lines":["f"]}],[{"start":{"row":59,"column":5},"end":{"row":59,"column":6},"action":"insert","lines":[" "],"id":3},{"start":{"row":59,"column":6},"end":{"row":59,"column":7},"action":"insert","lines":["d"]},{"start":{"row":59,"column":7},"end":{"row":59,"column":8},"action":"insert","lines":["e"]},{"start":{"row":59,"column":8},"end":{"row":59,"column":9},"action":"insert","lines":["t"]},{"start":{"row":59,"column":9},"end":{"row":59,"column":10},"action":"insert","lines":["e"]},{"start":{"row":59,"column":10},"end":{"row":59,"column":11},"action":"insert","lines":["r"]},{"start":{"row":59,"column":11},"end":{"row":59,"column":12},"action":"insert","lines":["m"]},{"start":{"row":59,"column":12},"end":{"row":59,"column":13},"action":"insert","lines":["i"]},{"start":{"row":59,"column":13},"end":{"row":59,"column":14},"action":"insert","lines":["e"]}],[{"start":{"row":59,"column":13},"end":{"row":59,"column":14},"action":"remove","lines":["e"],"id":4}],[{"start":{"row":59,"column":13},"end":{"row":59,"column":14},"action":"insert","lines":["n"],"id":5},{"start":{"row":59,"column":14},"end":{"row":59,"column":15},"action":"insert","lines":["e"]}],[{"start":{"row":59,"column":15},"end":{"row":59,"column":17},"action":"insert","lines":["()"],"id":6}],[{"start":{"row":59,"column":16},"end":{"row":59,"column":17},"action":"remove","lines":[")"],"id":7},{"start":{"row":59,"column":15},"end":{"row":59,"column":16},"action":"remove","lines":["("]}],[{"start":{"row":59,"column":15},"end":{"row":59,"column":16},"action":"insert","lines":["+"],"id":8}],[{"start":{"row":59,"column":15},"end":{"row":59,"column":16},"action":"remove","lines":["+"],"id":9}],[{"start":{"row":59,"column":15},"end":{"row":59,"column":16},"action":"insert","lines":["+"],"id":10}],[{"start":{"row":59,"column":15},"end":{"row":59,"column":16},"action":"remove","lines":["+"],"id":11}],[{"start":{"row":59,"column":15},"end":{"row":59,"column":16},"action":"insert","lines":[")"],"id":12}],[{"start":{"row":59,"column":15},"end":{"row":59,"column":16},"action":"remove","lines":[")"],"id":13}],[{"start":{"row":59,"column":15},"end":{"row":59,"column":16},"action":"insert","lines":["_"],"id":14},{"start":{"row":59,"column":16},"end":{"row":59,"column":17},"action":"insert","lines":["l"]},{"start":{"row":59,"column":17},"end":{"row":59,"column":18},"action":"insert","lines":["e"]},{"start":{"row":59,"column":18},"end":{"row":59,"column":19},"action":"insert","lines":["v"]},{"start":{"row":59,"column":19},"end":{"row":59,"column":20},"action":"insert","lines":["e"]},{"start":{"row":59,"column":20},"end":{"row":59,"column":21},"action":"insert","lines":["l"]}],[{"start":{"row":59,"column":21},"end":{"row":59,"column":23},"action":"insert","lines":["()"],"id":15}],[{"start":{"row":59,"column":22},"end":{"row":59,"column":23},"action":"insert","lines":["u"],"id":16},{"start":{"row":59,"column":23},"end":{"row":59,"column":24},"action":"insert","lines":["s"]},{"start":{"row":59,"column":24},"end":{"row":59,"column":25},"action":"insert","lines":["e"]},{"start":{"row":59,"column":25},"end":{"row":59,"column":26},"action":"insert","lines":["r"]}],[{"start":{"row":59,"column":27},"end":{"row":60,"column":0},"action":"insert","lines":["",""],"id":17},{"start":{"row":60,"column":0},"end":{"row":60,"column":4},"action":"insert","lines":["    "]},{"start":{"row":60,"column":4},"end":{"row":60,"column":5},"action":"insert","lines":["e"]},{"start":{"row":60,"column":5},"end":{"row":60,"column":6},"action":"insert","lines":["n"]},{"start":{"row":60,"column":6},"end":{"row":60,"column":7},"action":"insert","lines":["d"]},{"start":{"row":60,"column":2},"end":{"row":60,"column":4},"action":"remove","lines":["  "]}],[{"start":{"row":60,"column":2},"end":{"row":61,"column":0},"action":"insert","lines":["",""],"id":18},{"start":{"row":61,"column":0},"end":{"row":61,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":60,"column":2},"end":{"row":60,"column":4},"action":"insert","lines":["  "],"id":19}],[{"start":{"row":60,"column":4},"end":{"row":60,"column":5},"action":"insert","lines":["@"],"id":20},{"start":{"row":60,"column":5},"end":{"row":60,"column":6},"action":"insert","lines":["u"]},{"start":{"row":60,"column":6},"end":{"row":60,"column":7},"action":"insert","lines":["s"]},{"start":{"row":60,"column":7},"end":{"row":60,"column":8},"action":"insert","lines":["e"]},{"start":{"row":60,"column":8},"end":{"row":60,"column":9},"action":"insert","lines":["r"]}],[{"start":{"row":60,"column":9},"end":{"row":60,"column":10},"action":"insert","lines":[" "],"id":21},{"start":{"row":60,"column":10},"end":{"row":60,"column":11},"action":"insert","lines":["="]}],[{"start":{"row":60,"column":11},"end":{"row":60,"column":12},"action":"insert","lines":[" "],"id":22},{"start":{"row":60,"column":12},"end":{"row":60,"column":13},"action":"insert","lines":["u"]},{"start":{"row":60,"column":13},"end":{"row":60,"column":14},"action":"insert","lines":["s"]},{"start":{"row":60,"column":14},"end":{"row":60,"column":15},"action":"insert","lines":["e"]},{"start":{"row":60,"column":15},"end":{"row":60,"column":16},"action":"insert","lines":["r"]}],[{"start":{"row":60,"column":15},"end":{"row":60,"column":16},"action":"remove","lines":["r"],"id":23},{"start":{"row":60,"column":14},"end":{"row":60,"column":15},"action":"remove","lines":["e"]},{"start":{"row":60,"column":13},"end":{"row":60,"column":14},"action":"remove","lines":["s"]},{"start":{"row":60,"column":12},"end":{"row":60,"column":13},"action":"remove","lines":["u"]},{"start":{"row":60,"column":11},"end":{"row":60,"column":12},"action":"remove","lines":[" "]},{"start":{"row":60,"column":10},"end":{"row":60,"column":11},"action":"remove","lines":["="]},{"start":{"row":60,"column":9},"end":{"row":60,"column":10},"action":"remove","lines":[" "]},{"start":{"row":60,"column":8},"end":{"row":60,"column":9},"action":"remove","lines":["r"]},{"start":{"row":60,"column":7},"end":{"row":60,"column":8},"action":"remove","lines":["e"]},{"start":{"row":60,"column":6},"end":{"row":60,"column":7},"action":"remove","lines":["s"]},{"start":{"row":60,"column":5},"end":{"row":60,"column":6},"action":"remove","lines":["u"]},{"start":{"row":60,"column":4},"end":{"row":60,"column":5},"action":"remove","lines":["@"]}],[{"start":{"row":60,"column":4},"end":{"row":96,"column":5},"action":"insert","lines":["@user = user","    time = Time.zone.now","    cutoff = DateTime.new(0, 7, 22, 0, 0, 0)","    lev = \"\"","    if(time.strftime(\"%m\") < cutoff.strftime(\"%m\")) # Before July","      if(time.strftime(\"%d\") < cutoff.strftime(\"%d\")) # Before the 22nd","        if (@user.grade.to_i - time.strftime(\"%Y\").to_i == 0) # Senior","          lev = \"Se\"","        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 1) # Junior","         lev = \"Ju\"","        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 2) # Sophomore","         lev = \"So\"","        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 3) # Freshman","         lev = \"Fr\"","        else","          lev = \"N/A\"","        end","      end","    elsif(time.strftime(\"%m\") >= cutoff.strftime(\"%m\")) # During or after July","      if(time.strftime(\"%d\")) >= cutoff.strftime(\"%d\") # During or after the 22nd","        if (@user.grade.to_i - time.strftime(\"%Y\").to_i == 1) # Senior","          lev = \"Se\"","        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 2) # Junior","          lev = \"Ju\"","        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 3) # Sophomore","          lev = \"So\"","        elsif(@user.grade.to_i - time.strftime(\"%Y\").to_i == 4) # Freshman","            lev = \"Fr\"","        else","          lev = \"N/A\"","        end","      end","    else","      lev = \"N/A\"","    end","    return lev","  end"],"id":24}],[{"start":{"row":96,"column":4},"end":{"row":96,"column":5},"action":"remove","lines":["d"],"id":25},{"start":{"row":96,"column":3},"end":{"row":96,"column":4},"action":"remove","lines":["n"]},{"start":{"row":96,"column":2},"end":{"row":96,"column":3},"action":"remove","lines":["e"]},{"start":{"row":96,"column":0},"end":{"row":96,"column":2},"action":"remove","lines":["  "]},{"start":{"row":95,"column":14},"end":{"row":96,"column":0},"action":"remove","lines":["",""]}],[{"start":{"row":24,"column":23},"end":{"row":25,"column":0},"action":"insert","lines":["",""],"id":26},{"start":{"row":25,"column":0},"end":{"row":25,"column":6},"action":"insert","lines":["      "]},{"start":{"row":25,"column":6},"end":{"row":25,"column":7},"action":"insert","lines":["@"]},{"start":{"row":25,"column":7},"end":{"row":25,"column":8},"action":"insert","lines":["u"]},{"start":{"row":25,"column":8},"end":{"row":25,"column":9},"action":"insert","lines":["s"]},{"start":{"row":25,"column":9},"end":{"row":25,"column":10},"action":"insert","lines":["e"]},{"start":{"row":25,"column":10},"end":{"row":25,"column":11},"action":"insert","lines":["r"]},{"start":{"row":25,"column":11},"end":{"row":25,"column":12},"action":"insert","lines":["."]}],[{"start":{"row":25,"column":12},"end":{"row":25,"column":13},"action":"insert","lines":["u"],"id":27},{"start":{"row":25,"column":13},"end":{"row":25,"column":14},"action":"insert","lines":["p"]},{"start":{"row":25,"column":14},"end":{"row":25,"column":15},"action":"insert","lines":["d"]},{"start":{"row":25,"column":15},"end":{"row":25,"column":16},"action":"insert","lines":["a"]},{"start":{"row":25,"column":16},"end":{"row":25,"column":17},"action":"insert","lines":["t"]},{"start":{"row":25,"column":17},"end":{"row":25,"column":18},"action":"insert","lines":["e"]}],[{"start":{"row":25,"column":17},"end":{"row":25,"column":18},"action":"remove","lines":["e"],"id":28},{"start":{"row":25,"column":16},"end":{"row":25,"column":17},"action":"remove","lines":["t"]},{"start":{"row":25,"column":15},"end":{"row":25,"column":16},"action":"remove","lines":["a"]},{"start":{"row":25,"column":14},"end":{"row":25,"column":15},"action":"remove","lines":["d"]},{"start":{"row":25,"column":13},"end":{"row":25,"column":14},"action":"remove","lines":["p"]},{"start":{"row":25,"column":12},"end":{"row":25,"column":13},"action":"remove","lines":["u"]}],[{"start":{"row":25,"column":12},"end":{"row":25,"column":13},"action":"insert","lines":["u"],"id":29},{"start":{"row":25,"column":13},"end":{"row":25,"column":14},"action":"insert","lines":["p"]},{"start":{"row":25,"column":14},"end":{"row":25,"column":15},"action":"insert","lines":["d"]}],[{"start":{"row":25,"column":12},"end":{"row":25,"column":15},"action":"remove","lines":["upd"],"id":30},{"start":{"row":25,"column":12},"end":{"row":25,"column":28},"action":"insert","lines":["update_attribute"]}],[{"start":{"row":25,"column":28},"end":{"row":25,"column":30},"action":"insert","lines":["()"],"id":31}],[{"start":{"row":25,"column":29},"end":{"row":25,"column":30},"action":"insert","lines":[":"],"id":32},{"start":{"row":25,"column":30},"end":{"row":25,"column":31},"action":"insert","lines":["l"]}],[{"start":{"row":25,"column":30},"end":{"row":25,"column":31},"action":"remove","lines":["l"],"id":33},{"start":{"row":25,"column":29},"end":{"row":25,"column":30},"action":"remove","lines":[":"]}],[{"start":{"row":25,"column":29},"end":{"row":25,"column":30},"action":"insert","lines":[":"],"id":34},{"start":{"row":25,"column":30},"end":{"row":25,"column":31},"action":"insert","lines":["k"]},{"start":{"row":25,"column":31},"end":{"row":25,"column":32},"action":"insert","lines":["e"]},{"start":{"row":25,"column":32},"end":{"row":25,"column":33},"action":"insert","lines":["v"]},{"start":{"row":25,"column":33},"end":{"row":25,"column":34},"action":"insert","lines":["e"]}],[{"start":{"row":25,"column":33},"end":{"row":25,"column":34},"action":"remove","lines":["e"],"id":35},{"start":{"row":25,"column":32},"end":{"row":25,"column":33},"action":"remove","lines":["v"]},{"start":{"row":25,"column":31},"end":{"row":25,"column":32},"action":"remove","lines":["e"]},{"start":{"row":25,"column":30},"end":{"row":25,"column":31},"action":"remove","lines":["k"]}],[{"start":{"row":25,"column":30},"end":{"row":25,"column":31},"action":"insert","lines":["l"],"id":36},{"start":{"row":25,"column":31},"end":{"row":25,"column":32},"action":"insert","lines":["e"]},{"start":{"row":25,"column":32},"end":{"row":25,"column":33},"action":"insert","lines":["v"]},{"start":{"row":25,"column":33},"end":{"row":25,"column":34},"action":"insert","lines":["l"]}],[{"start":{"row":25,"column":33},"end":{"row":25,"column":34},"action":"remove","lines":["l"],"id":37}],[{"start":{"row":25,"column":33},"end":{"row":25,"column":34},"action":"insert","lines":["e"],"id":38},{"start":{"row":25,"column":34},"end":{"row":25,"column":35},"action":"insert","lines":["l"]}],[{"start":{"row":25,"column":35},"end":{"row":25,"column":36},"action":"insert","lines":[" "],"id":39}],[{"start":{"row":25,"column":35},"end":{"row":25,"column":36},"action":"remove","lines":[" "],"id":40}],[{"start":{"row":25,"column":35},"end":{"row":25,"column":36},"action":"insert","lines":[","],"id":41}],[{"start":{"row":25,"column":36},"end":{"row":25,"column":37},"action":"insert","lines":[" "],"id":42}],[{"start":{"row":25,"column":37},"end":{"row":25,"column":38},"action":"insert","lines":["d"],"id":43},{"start":{"row":25,"column":38},"end":{"row":25,"column":39},"action":"insert","lines":["e"]},{"start":{"row":25,"column":39},"end":{"row":25,"column":40},"action":"insert","lines":["t"]},{"start":{"row":25,"column":40},"end":{"row":25,"column":41},"action":"insert","lines":["e"]},{"start":{"row":25,"column":41},"end":{"row":25,"column":42},"action":"insert","lines":["r"]},{"start":{"row":25,"column":42},"end":{"row":25,"column":43},"action":"insert","lines":["m"]},{"start":{"row":25,"column":43},"end":{"row":25,"column":44},"action":"insert","lines":["i"]},{"start":{"row":25,"column":44},"end":{"row":25,"column":45},"action":"insert","lines":["n"]},{"start":{"row":25,"column":45},"end":{"row":25,"column":46},"action":"insert","lines":["e"]}],[{"start":{"row":25,"column":37},"end":{"row":25,"column":46},"action":"remove","lines":["determine"],"id":44},{"start":{"row":25,"column":37},"end":{"row":25,"column":54},"action":"insert","lines":["determine_level()"]}],[{"start":{"row":25,"column":53},"end":{"row":25,"column":54},"action":"insert","lines":["@"],"id":45},{"start":{"row":25,"column":54},"end":{"row":25,"column":55},"action":"insert","lines":["u"]},{"start":{"row":25,"column":55},"end":{"row":25,"column":56},"action":"insert","lines":["s"]},{"start":{"row":25,"column":56},"end":{"row":25,"column":57},"action":"insert","lines":["e"]},{"start":{"row":25,"column":57},"end":{"row":25,"column":58},"action":"insert","lines":["r"]}],[{"start":{"row":15,"column":12},"end":{"row":15,"column":13},"action":"insert","lines":["'"],"id":46}],[{"start":{"row":15,"column":13},"end":{"row":16,"column":0},"action":"insert","lines":["",""],"id":47},{"start":{"row":16,"column":0},"end":{"row":16,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":16,"column":0},"end":{"row":16,"column":2},"action":"remove","lines":["  "],"id":48},{"start":{"row":15,"column":13},"end":{"row":16,"column":0},"action":"remove","lines":["",""]},{"start":{"row":15,"column":12},"end":{"row":15,"column":13},"action":"remove","lines":["'"]}],[{"start":{"row":15,"column":12},"end":{"row":16,"column":0},"action":"insert","lines":["",""],"id":49},{"start":{"row":16,"column":0},"end":{"row":16,"column":4},"action":"insert","lines":["    "]},{"start":{"row":16,"column":4},"end":{"row":16,"column":5},"action":"insert","lines":["d"]},{"start":{"row":16,"column":5},"end":{"row":16,"column":6},"action":"insert","lines":["e"]},{"start":{"row":16,"column":6},"end":{"row":16,"column":7},"action":"insert","lines":["b"]},{"start":{"row":16,"column":7},"end":{"row":16,"column":8},"action":"insert","lines":["u"]},{"start":{"row":16,"column":8},"end":{"row":16,"column":9},"action":"insert","lines":["g"]},{"start":{"row":16,"column":9},"end":{"row":16,"column":10},"action":"insert","lines":["g"]},{"start":{"row":16,"column":10},"end":{"row":16,"column":11},"action":"insert","lines":["e"]},{"start":{"row":16,"column":11},"end":{"row":16,"column":12},"action":"insert","lines":["r"]}]]},"ace":{"folds":[],"scrolltop":450,"scrollleft":0,"selection":{"start":{"row":18,"column":34},"end":{"row":18,"column":34},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":32,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1582229405223}