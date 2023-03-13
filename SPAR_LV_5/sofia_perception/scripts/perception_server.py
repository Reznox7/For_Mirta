#!/usr/bin/env python3

import rospy
import numpy as np
import ros_numpy
from geometry_msgs.msg import Point
from sofia_perception.srv import DetectObject, DetectObjectResponse


class SofiaPerception(object):
    def __init__(self):
        self.detect_object_srv = rospy.Service(
            'detect_object', DetectObject, self.detect_object)
        self.z = 0.32
        print("DetectObject srv is now available")
        rospy.spin()

    def detect_object(self, req):
        self.points = ros_numpy.point_cloud2.pointcloud2_to_array(req.input_pc)
        z_values = self.points['z']
        mask = ~np.isnan(z_values) * (z_values > self.z) * \
            (z_values < self.z + 0.15)
        self.points = self.points[mask]

        x_values = self.points['x']
        y_values = self.points['y']
        z_values = self.points['z']

        x = np.sum(x_values)
        y = np.sum(y_values)
        z = np.sum(z_values)

        object_centroid = Point()
        object_centroid.x = x/x_values.size
        object_centroid.y = y/y_values.size
        object_centroid.z = z/z_values.size

        res = DetectObjectResponse()
        res.object_centroid = object_centroid

        return res


def main():
    rospy.init_node('detect_object_server')
    perception = SofiaPerception()


if __name__ == "__main__":
    main()
