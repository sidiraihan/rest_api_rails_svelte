<script>
    import { key } from "./util.js";

    let users_data = [];
    let error = '';
    const getUsers = async () => {
        const response = await fetch("http://localhost:4000/users", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " +$key,
                "Accept": "application/json",
            },
        });
        users_data = await response.json();
        if (users_data.error) {
            error = users_data.error;
        }
    };

    if (localStorage.getItem("key").length > 0) {
        getUsers();
    }
</script>

<h1>User Data</h1>
{#each users_data as user}
    <div
        class="container bg-light d-flex my-2 pt-3 justify-content-between flex-column">
        <b>username :</b>
        <p>{user.username}</p>
        <b>age :</b>
        <p>{user.age}</p>
    </div>
{/each}

{#if error}
    <p>{error}</p>
{/if}
