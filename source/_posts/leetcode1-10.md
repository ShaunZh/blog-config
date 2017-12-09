
---
title: leetcode1-10
date: 2017-09-10 17:30:38
categories:
tags: leetcode
---
## two sum 
**description**:
Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.
**example**:
```
Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1]
```

**my solution**
```
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
function sort(nums) {
    let newArr = nums.concat();
    for(let i = 1, len = nums.length; i < len; i++) {
        let temp = newArr[i];
        for (let j = i; j >=0; j--) {
            if (newArr[j - 1] > temp) {
                newArr[j] = newArr[j - 1];
            } else {
                newArr[j] = temp;
                break;
            }
        }
    }    
    return newArr;
}
var twoSum = function(nums, target) {
    let newArr = sort(nums);
    let result = [];
    let index = function() {
        for (let i = 0, len = newArr.length; i < len; i++) {
            if (newArr[i] >= target) {
                return i;
            }  
        }
        return newArr.length;
    }();
    for (let i = 0, len = index; i <= len; i++) {
        let temp = newArr[i];
        let goal = target - temp;
        for (let j = i + 1; j <= index; j++) {
            if (newArr[j] === goal) {
                result[0] = nums.indexOf(temp);
                result[1] = nums.indexOf(goal);
                return result;
            }
        }
    }
    return result;
};
```

**recommend solution**
方法1：
```
var twoSum = function(nums, target) {
    let len = nums.length;
    for (let i = 0; i < len; i++) {
        for (let j = i + 1; j < len; j++) {
            if (nums[j] === (target - nums[i])) {
                return [i, j];
            }
        }
    }
};
```
