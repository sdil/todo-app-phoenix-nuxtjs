<template>
  <section class="section">
    <ul v-for="todo in todos" :key="todo.id">
      <li>{{ todo.title }}</li>
    </ul>
  </section>
</template>
<script>
export default {
  data() {
    return {
      todos: [
        {
          id: 1,
          title: "milk the cow",
        },
      ],
    };
  },
  created() {
    // request to API server for list of items
  }
};
</script>