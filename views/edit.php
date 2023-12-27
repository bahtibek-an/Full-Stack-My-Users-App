<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<style>
    * {
        margin: 0 auto;
    }
    form {
        margin: 0 auto;
        
}

.main_box
{
    display:flex;
    justify-content: center;
    margin-top:250px;
}
.input-field {
  position: relative;
  width: 250px;
  height: 44px;
  line-height: 44px;
  margin:20px;
}
label {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  color: #d3d3d3;
  transition: 0.2s all;
  cursor: text;
}
input {
  width: 100%;
  border: 0;
  outline: 0;
  padding: 0.5rem 0;
  border-bottom: 2px solid #d3d3d3;
  box-shadow: none;
  color: #111;
}
input:invalid {
  outline: 0;
  // color: #ff2300;
  //   border-color: #ff2300;
}
input:focus,
input:valid {
  border-color: #00dd22;
}
input:focus~label,
input:valid~label {
  font-size: 14px;
  top: -24px;
  color: #00dd22;
}

</style>


<body>
    
    <?php 
        $userController = new \controller\UserController();

        if (isset($_GET['id'])){
            $user_id = $_GET['id'];
            $user_data = $userController->findUser($user_id);
            echo '<div class="main_box">';
                echo '<form class="form" method="post" action="/users">';
                    echo '<input type="hidden" name="action" value="edit">';
                    echo '<input type="hidden" name="user_id" value="' . $user_data['id'] . '"> <br>';
                    
                    echo '<div class="input-field">';
                        echo '<input type="text"  id="name" required name="firstname" value="' . $user_data['firstname'] . '"> <br>';
                        echo '<label for="firstname">First Name:<label">';
                    echo '</div>';
                    ////////////////  lastname ////////////////
                    echo '<div class="input-field">';
                        echo '<input type="text" id="name" name="lastname" value="' . $user_data['lastname'] . '"> <br>';
                        echo '<label for="lastname">Last Name:<label">';
                    echo '</div>';
                    echo '<div class="input-field">';
                    echo '<input  autocomplete="off" required type="email" id="name" autocomplete="off" required name="email" value="' . $user_data['email'] . '"> <br>';
                        echo '<label for="email">Email:<label">';
                    echo '</div>';
                    echo '<div class="input-field">';
                        echo '<input  type="submit" value="Save Changes">';
                    echo '</div>';
                echo '</form>';
            echo '</div>';
        }else{
            echo 'Invalid request';
        }
    ?>
</body>
</html>




