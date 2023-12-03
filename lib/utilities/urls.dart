const baseUrl = 'https://task.teamrabbil.com/api/v1';

const registerUrl = '$baseUrl/registration';

const loginUrl = '$baseUrl/login';

const createTaskUrl = '$baseUrl/createTask';

const getNewTastUrl = '$baseUrl/listTaskByStatus/new';

const getProgressTaskUrl = '$baseUrl/listTaskByStatus/progress';
const getCancelledTaskUrl = '$baseUrl/listTaskByStatus/cancelled';
const getCompleteTaskUrl = '$baseUrl/listTaskByStatus/Completed';
const getTaskStatusUrl = '$baseUrl/taskStatusCount';

String updateTaskUrl(String id, String updateType) =>
    '$baseUrl//updateTaskStatus/$id/$updateType';

const profileUpdateUrl = '$baseUrl/profileUpdate';

String deleteTaskUrl(String id) => '$baseUrl//deleteTask/$id';
