<script>
import {key} from './util.js';


  let password = "";
  let username = "";
  let token = "";
  let error;
  let users_data = [];
  let user = { loggedIn: false };
  
  const handleLogin = async () => {
    const response = await fetch("http://localhost:4000/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: JSON.stringify({ username, password }),
	});
	
	const parsed = await response.json();
	
	token = parsed.token;

    if (parsed.error) {
	  error = parsed.error;
	  console.log(parsed);

    } else {
	  window.localStorage.setItem('key', token);
	  user.loggedIn = !user.loggedIn;
	  getUsers();
	}
	
  };

  const handleLogout = async () => {
	user.loggedIn = !user.loggedIn;
	key.set('')
	password = "";
	username = "";
	token = "";
	users_data = [];
  };



  const getUsers = async () => {	
	const response = await fetch("http://localhost:4000/users", {
      method: "GET",
      headers: {
		"Content-Type": "application/json",
		"Authorization": "Bearer "+localStorage.getItem("key"),
        "Accept": "application/json",
	  },	  
	});
	users_data = await response.json();
  };


  if(localStorage.getItem("key").length > 0){
	getUsers();
  }
</script>




<head>
	<link
	  rel="stylesheet"
	  href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	/>
  </head>

<!--if not logged in-->


{#if !user.loggedIn}
<form on:submit|preventDefault="{handleLogin}" method="post">
  <label>
    Username:
    <input type="text" bind:value="{username}" />
  </label>
  <label>
    Password:
    <input type="password" bind:value="{password}" />
  </label>
  <button type="submit">Login</button>
</form>
{/if}


<!-- logged in show user data-->
{#if user.loggedIn}
<h1>User Data</h1>

<button class="btn btn-primary" on:click="{handleLogout}">Logout</button>

{#each users_data as user}
<div class="container bg-light d-flex my-2 pt-3 justify-content-between flex-column">
	<b>username</b> <p>{user.username}</p>
	<b>age</b> <p>{user.age}</p>
</div>
{/each}
{/if}

{#if error}
<p>{error}</p>
{/if}